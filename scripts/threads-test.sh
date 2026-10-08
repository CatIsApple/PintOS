#!/usr/bin/env bash
# Run the supplied Threads tests without changing the assignment implementation.
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export PATH="$repo_dir/pintos/utils:$PATH"
test_name="${1:-all}"

if [[ $# -gt 1 || ! "$test_name" =~ ^[a-z0-9-]+$ ]]; then
  echo "Usage: $0 [all|alarm-single|priority-preempt|mlfqs-load-1|...]" >&2
  exit 2
fi

if [[ "$test_name" != all ]]; then
  test_path="tests/threads/$test_name"
  [[ "$test_name" == mlfqs-* ]] && test_path="tests/threads/mlfqs/$test_name"
  if [[ ! -f "$repo_dir/pintos/$test_path.ck" ]]; then
    echo "Unknown Threads test: $test_name" >&2
    exit 2
  fi
fi

make -C "$repo_dir/pintos/threads"
cd "$repo_dir/pintos/threads/build"

# Always rerun selected tests; do not report an old .result as fresh evidence.
if [[ "$test_name" == all ]]; then
  find tests/threads -type f \( -name '*.output' -o -name '*.errors' -o -name '*.result' \) -delete
  rm -f results
  make check
else
  rm -f "$test_path.output" "$test_path.errors" "$test_path.result"
  make "$test_path.result"
  cat "$test_path.result"
  if ! grep -qx PASS "$test_path.result"; then
    echo "Execution log: $PWD/$test_path.output" >&2
    exit 1
  fi
fi
