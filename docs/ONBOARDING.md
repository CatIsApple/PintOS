# 환경 설정 · 팀원 초대

## 초대와 접근 권한

저장소 소유자는 [저장소 설정](https://github.com/CatIsApple/PintOS/settings)의 접근 권한 관리에서 GitHub 계정으로 협업자를 초대할 수 있습니다. [Project](https://github.com/users/CatIsApple/projects/6)의 접근 권한은 별도로 설정합니다. 보드 편집에는 **Write** 권한이 필요합니다.

초대를 받은 계정으로 로그인해 수락하면 비공개 저장소와 보드에 접근할 수 있습니다.

## 준비할 도구

- Docker Desktop
- Git, VS Code
- VS Code의 Dev Containers 확장
- 비공개 저장소를 clone할 수 있는 GitHub 인증

## 컨테이너 실행

Docker Desktop을 실행하고 저장소를 엽니다.

```bash
git clone https://github.com/CatIsApple/PintOS.git
cd PintOS
code .
```

VS Code 명령 팔레트에서 **Dev Containers: Reopen in Container**를 선택합니다. 개발 환경은 Ubuntu 22.04 / amd64이며, 컨테이너 안의 작업 경로는 `/workspaces/PintOS`입니다.

## 빌드와 테스트

컨테이너 터미널에서 실행합니다.

```bash
cd /workspaces/PintOS
./scripts/threads-test.sh alarm-zero
./scripts/threads-test.sh all
```

스크립트는 빌드 후 지정 테스트 또는 전체 테스트를 실행하며, 실패하면 0이 아닌 종료 코드를 반환합니다.

직접 빌드할 경우:

```bash
cd /workspaces/PintOS/pintos
source activate
cd threads
make
make check
```

`source activate`는 현재 터미널에서 PintOS 유틸리티를 찾게 합니다.

## 결과 파일

| 내용 | 경로 |
| --- | --- |
| 전체 요약 | `pintos/threads/build/results` |
| 개별 실행 로그 | `pintos/threads/build/tests/threads/<test-name>.output` |
| MLFQS 실행 로그 | `pintos/threads/build/tests/threads/mlfqs/<test-name>.output` |
| 개별 판정 | 로그와 같은 경로의 `<test-name>.result` |

자동 실행 결과는 [Actions](https://github.com/CatIsApple/PintOS/actions)에서 확인할 수 있습니다. **Threads checks → Run workflow**에서 전체 테스트를 수동 실행할 수도 있습니다.
