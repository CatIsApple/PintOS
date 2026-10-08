# PintOS · 7주차 팀 프로젝트

Krafton Jungle **Project 1: Threads**를 학습하고 구현하는 비공개 팀 저장소입니다. 이번 주 범위는 Alarm Clock, Priority Scheduling, Priority Donation, MLFQS입니다.

현재는 팀 협업 환경을 준비한 단계입니다. 제공된 기본 코드에는 과제 구현이 남아 있으므로 전체 테스트가 통과하지 않을 수 있습니다.

| 바로가기 | 내용 |
| --- | --- |
| [팀 작업 보드](https://github.com/users/CatIsApple/projects/6) | 사람별 담당, 진행 상태, 미배정 작업 |
| [이슈](https://github.com/CatIsApple/PintOS/issues) | 공식 35개 체크리스트와 구현 작업 |
| [팀 운영 규칙](docs/TEAM.md) | 역할 제안, 학습·구현 순서, 리뷰와 완료 기준 |
| [팀원 시작 안내](docs/ONBOARDING.md) | 초대 수락, 환경 실행, 첫 PR |

## 처음 시작하기

저장소 초대를 수락한 뒤 Docker Desktop, VS Code, VS Code의 Dev Containers 확장을 준비합니다.

```bash
git clone https://github.com/CatIsApple/PintOS.git
cd PintOS
code .
```

VS Code 명령 팔레트에서 **Dev Containers: Reopen in Container**를 실행합니다. 컨테이너는 Ubuntu 22.04 / amd64이며 작업 경로는 `/workspaces/PintOS`입니다. Apple Silicon에서는 amd64 에뮬레이션으로 실행하므로 첫 빌드가 오래 걸릴 수 있습니다.

컨테이너 터미널에서 빌드하고 테스트합니다.

```bash
cd /workspaces/PintOS
./scripts/threads-test.sh alarm-zero
./scripts/threads-test.sh all
```

기본 명령을 직접 실행하려면:

```bash
cd /workspaces/PintOS/pintos
source activate
cd threads
make
make check
```

전체 결과는 `pintos/threads/build/results`, 개별 로그는 `pintos/threads/build/tests/threads/` 아래의 `.output` 파일에서 확인합니다. MLFQS 로그는 그 안의 `mlfqs/`에 있습니다. 구현 전 결과를 [#6 입문 학습](https://github.com/CatIsApple/PintOS/issues/6)에 기록하고 변경 후 결과와 비교하세요. 자동 CI는 빌드와 `alarm-zero`를 확인하며, 전체 테스트는 Actions에서 수동 실행할 수 있습니다. 자동 CI 성공만으로 과제 전체 완료를 판단하지 않습니다.

## 함께 작업하기

1. 보드의 미배정 이슈를 확인하고 **Assignees에 실제 담당자 1명**을 지정합니다. 한 사람은 구현 이슈 하나만 `In progress`로 진행합니다.
2. 최신 `main`에서 `feature/<github-id>/<topic>` 브랜치를 만듭니다.
3. 작은 단위로 구현하고 관련 테스트 결과를 남깁니다. PR에 `Closes #이슈번호`를 연결합니다.
4. 작성자를 제외한 팀원 1명이 코드를 리뷰하고 테스트 근거를 확인한 뒤 `main`에 병합합니다. 작은 PR을 매일 통합합니다.

**테스트 근거 + 다른 팀원 리뷰 + `main` 병합**을 모두 충족하면 구현 이슈를 완료합니다. GitHub 설정에 의한 강제 여부와 관계없이 이 규칙을 적용합니다.

## 코드 읽기와 구현 순서

`struct thread`와 READY / RUNNING / BLOCKED 이해 → Alarm Clock → 기본 우선순위·선점 → 동기화 대기 순서 → 단일·복수 기부 → 중첩 기부 → MLFQS → 전체 회귀 테스트 순서로 진행합니다.

첫 읽기 대상은 `pintos/include/threads/thread.h`, `pintos/threads/thread.c`, `pintos/devices/timer.c`, `pintos/threads/synch.c`입니다. 기능마다 요구사항을 읽고 상태 변화를 그린 뒤 직접 구현합니다. AI와 참고 코드는 개념·코드 흐름·실패 원인을 이해하는 데 활용하고, 팀원이 변경 이유를 설명할 수 있는 코드를 병합합니다.

## 과제와 원본 자료

- [7주차 LMS](https://jungle-lms.krafton.com/learning/1316)
- [KAIST PintOS Project 1 명세](https://casys-kaist.github.io/pintos-kaist/project1/introduction.html)
- [공식 이슈 CSV](https://github.com/krafton-jungle/SW-AI-ISSUE-TEMPLATE/blob/main/week7_issues_complete.csv)
- [원본 Docker 저장소](https://github.com/krafton-jungle/pintos_22.04_lab_docker)
- [원본 PintOS 저장소](https://github.com/krafton-jungle/pintos_ubuntu_22.04)
- [보존한 원본 환경 안내](docs/UPSTREAM-README.md) — 원본 저장소명·이전 주차 표기가 포함되어 있습니다. 이 팀 저장소의 실행·협업 방법은 위 안내를 따릅니다.
