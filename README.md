# PintOS · WEEK7

Krafton Jungle · **Project 1: Threads**

Alarm Clock · Priority Scheduling · Priority Donation · MLFQS

| 작업 공간 | 개발 안내 |
| --- | --- |
| [팀 진행 보드](https://github.com/users/CatIsApple/projects/6) | [환경 설정 · 팀원 초대](docs/ONBOARDING.md) |
| [WEEK7 이슈](https://github.com/CatIsApple/PintOS/issues) | [빌드와 테스트](#빌드와-테스트) |

## 개발 환경

Docker Desktop, VS Code, VS Code의 **Dev Containers** 확장을 준비합니다.

```bash
git clone https://github.com/CatIsApple/PintOS.git
cd PintOS
code .
```

VS Code 명령 팔레트에서 **Dev Containers: Reopen in Container**를 실행합니다. 컨테이너는 Ubuntu 22.04 / amd64이며 작업 경로는 `/workspaces/PintOS`입니다. Apple Silicon에서는 amd64 에뮬레이션을 사용합니다.

## 빌드와 테스트

컨테이너 터미널에서 실행합니다.

```bash
cd /workspaces/PintOS
./scripts/threads-test.sh alarm-zero
./scripts/threads-test.sh all
```

스크립트는 빌드 후 지정한 테스트를 실행합니다. `all`은 전체 테스트를 실행합니다.

기본 명령을 직접 실행할 수도 있습니다.

```bash
cd /workspaces/PintOS/pintos
source activate
cd threads
make
make check
```

| 결과 | 경로 |
| --- | --- |
| 전체 요약 | `pintos/threads/build/results` |
| 개별 로그 | `pintos/threads/build/tests/threads/*.output` |
| MLFQS 로그 | `pintos/threads/build/tests/threads/mlfqs/*.output` |

## 참고 자료

- [7주차 LMS](https://jungle-lms.krafton.com/learning/1316)
- [KAIST PintOS Project 1 명세](https://casys-kaist.github.io/pintos-kaist/project1/introduction.html)
- [공식 이슈 CSV](https://github.com/krafton-jungle/SW-AI-ISSUE-TEMPLATE/blob/main/week7_issues_complete.csv)
- [원본 Docker 저장소](https://github.com/krafton-jungle/pintos_22.04_lab_docker)
- [원본 PintOS 저장소](https://github.com/krafton-jungle/pintos_ubuntu_22.04)
- [원본 환경 안내](docs/UPSTREAM-README.md)
