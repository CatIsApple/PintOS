# 팀원 시작 안내

## 저장소 소유자가 할 일

1. 팀원의 이름과 정확한 GitHub ID를 받습니다.
2. [저장소 설정](https://github.com/CatIsApple/PintOS/settings)에서 접근 권한 관리 항목을 열어 해당 계정을 협업자로 초대합니다.
3. 팀원이 초대를 수락했는지 확인합니다. 비공개 저장소 링크만 전달해서는 접근 권한이 생기지 않습니다.
4. [팀 Project](https://github.com/users/CatIsApple/projects/6)의 접근 권한 설정에서 팀원에게 **Write** 권한을 부여합니다.
5. [팀 운영 문서](TEAM.md)에 이름·ID를 반영하고 합의한 이슈의 Assignees를 지정합니다.

**저장소 권한과 Project 권한은 별도로 관리됩니다.** 저장소에 초대했다고 Project 편집 권한까지 부여되지는 않습니다. Project 권한만 있어도 비공개 저장소의 이슈 내용을 볼 수 있는 것은 아니므로 양쪽 권한을 확인하세요.

## 팀원이 할 일

초대를 받을 GitHub 계정으로 로그인해 저장소 초대를 수락합니다. [저장소](https://github.com/CatIsApple/PintOS)와 연결된 팀 보드가 열리고, 자신의 이슈 상태를 수정할 수 있는지 확인합니다.

컴퓨터에 다음을 준비합니다.

- Docker Desktop — 실행 중이어야 합니다.
- Git, VS Code.
- VS Code의 Dev Containers 확장.
- 비공개 저장소를 clone할 수 있는 GitHub 인증. HTTPS 인증에는 GitHub CLI 로그인 또는 Git credential manager 등을 사용할 수 있습니다.

```bash
git clone https://github.com/CatIsApple/PintOS.git
cd PintOS
code .
```

VS Code 명령 팔레트에서 **Dev Containers: Reopen in Container**를 선택합니다. 개발 환경은 Ubuntu 22.04 / amd64로 통일합니다. 컨테이너 안의 작업 경로는 `/workspaces/PintOS`입니다.

첫 실행은 컨테이너 터미널에서 확인합니다.

```bash
cd /workspaces/PintOS
./scripts/threads-test.sh alarm-zero
./scripts/threads-test.sh all
```

스크립트는 먼저 빌드한 뒤 지정 테스트 또는 전체 테스트를 실행하며, 실패하면 0이 아닌 종료 코드를 반환합니다. 기본 코드에서 일부 테스트가 실패하는 것은 구현 전 상태일 수 있습니다. 환경 오류와 미구현 테스트 실패를 구분하고 첫 결과를 [#6 입문 학습](https://github.com/CatIsApple/PintOS/issues/6)에 남깁니다.

직접 빌드할 경우:

```bash
cd /workspaces/PintOS/pintos
source activate
cd threads
make
make check
```

`source activate`는 현재 터미널에서 PintOS 유틸리티를 찾게 합니다. 컨테이너 밖의 macOS나 Windows 터미널이 아니라 컨테이너 터미널에서 빌드하세요.

## 첫 작업과 PR

보드에서 담당 이슈 1개를 정하고 Assignees에 자신을 지정합니다. 이슈의 요구사항·관련 테스트·수정할 파일을 읽은 뒤 시작합니다.

```bash
git switch main
git pull --ff-only origin main
git switch -c feature/<github-id>/<topic>
```

`<github-id>`와 `<topic>`을 자신의 값으로 바꿉니다. 예: `feature/CatIsApple/alarm-clock`.

변경 후 관련 테스트를 실행하고, 수정한 파일만 선택해 커밋합니다.

```bash
git status
git add <수정한-파일>
git commit -m "feat: implement alarm sleep and wakeup"
git push -u origin HEAD
```

GitHub에서 `main`으로 PR을 만들고 본문에 `Closes #이슈번호`와 테스트 결과를 적습니다. 팀원 한 명에게 리뷰를 요청하고 보드 상태를 `In review`로 옮깁니다. 다른 팀원의 리뷰를 받은 뒤 병합하고, 다음 작업은 최신 `main`에서 새 브랜치로 시작합니다.

## 테스트 결과 읽기

- 전체 요약: `pintos/threads/build/results`.
- 개별 실행 로그: `pintos/threads/build/tests/threads/<test-name>.output`.
- MLFQS 실행 로그: `pintos/threads/build/tests/threads/mlfqs/<test-name>.output`.
- 개별 판정: 같은 경로의 `<test-name>.result`.
- 자동 CI: 빌드와 `alarm-zero` smoke 테스트.
- 전체 CI: Actions 탭에서 수동 실행하는 전체 테스트 workflow.

PR에는 통과한 테스트 이름과 실패한 테스트 이름을 구분하고, 필요한 경우 로그의 관련 부분을 붙입니다. 미구현 기능의 기존 실패와 이번 변경으로 새로 생긴 실패를 구분하세요.

## 막혔을 때 공유할 정보

실행한 명령, 현재 브랜치·커밋, 컨테이너 실행 여부, 기대한 결과와 실제 로그를 이슈에 남깁니다. 테스트 실패라면 재현할 테스트 하나를 먼저 좁혀 함께 봅니다.
