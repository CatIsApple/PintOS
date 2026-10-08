# 팀 운영

## 구성과 배정

현재 확인된 팀원은 **김다온 (`CatIsApple`)**입니다. 다른 두 팀원은 이름과 GitHub ID를 확인한 뒤 초대하고 실제 Assignees를 지정합니다. 아래 분담은 첫 회의에서 조정할 **제안**입니다.

| 사람 | 첫 담당 제안 | 함께 확인할 내용 |
| --- | --- | --- |
| 김다온 (`CatIsApple`) | 환경·보드 관리, Alarm Clock | 상태 전환과 타이머 인터럽트 |
| 미배정 — 팀원 정보 확인 후 지정 | Priority Scheduling, 동기화 대기 순서 | 우선순위 변경과 선점 시점 |
| 미배정 — 팀원 정보 확인 후 지정 | Priority Donation | lock 소유 관계와 기부 복구 |
| 팀 전체 | MLFQS 설계·통합·최종 검증 | 계산, 갱신 시점, 두 스케줄러 모드의 차이 |

미확인 팀원을 가상의 GitHub 사용자로 배정하지 않습니다. `Assignees`가 비어 있는 상태로 두고, 실제 합의가 되면 담당자를 지정합니다. 기부 담당자는 기본 우선순위 구현을 기다리는 동안 기부 시나리오와 관련 테스트를 먼저 읽을 수 있습니다.

## 보드 사용법

[팀 작업 보드](https://github.com/users/CatIsApple/projects/6)에서 진행 상태와 담당자를 확인합니다.

- **팀 진행:** 팀 전체의 작업 상태를 확인합니다.
- **김다온:** `CatIsApple`에게 배정된 작업을 확인합니다. 팀원 ID가 확인되면 같은 방식으로 이름별 보기를 추가합니다.
- **미배정:** Assignees가 없는 작업을 모아 첫 회의와 매일 점검 때 나눕니다.
- **전체 계획:** `Assignees`로 그룹화해 사람별 업무량과 전체 작업을 확인합니다. 실제 이름과 GitHub ID의 대응은 이 문서에 유지합니다.
- **상태:** `Todo`(착수 전) → `In progress`(진행 중) → `In review`(리뷰 중) → `Done`(완료).
- **진행 제한:** 1인당 진행 중인 구현 이슈는 1개입니다. 리뷰나 짧은 학습 작업은 병행할 수 있습니다.
- **두 종류의 이슈:** 공식 35개 항목은 누락을 확인하는 체크리스트이고, 구현 이슈는 PR로 끝낼 작업 단위입니다. 관련 공식 항목을 구현 이슈 본문에 연결합니다.

공식 체크리스트는 공통 업무 5개, 학습 3개, 테스트 27개입니다. 체크리스트의 나열 순서대로 코드를 구현할 필요는 없습니다. 테스트 이슈는 해당 테스트의 통과 근거를 남긴 뒤 완료하며, 공통 업무·학습 이슈는 자료나 설명 등 본문의 완료 조건으로 판단합니다.

## 구현 작업 8개

| 순서 | 작업 | 의존 관계와 완료 근거 |
| --- | --- | --- |
| 1 | [#36 Alarm Clock](https://github.com/CatIsApple/PintOS/issues/36) | `alarm-zero`, `alarm-negative`, `alarm-single`, `alarm-multiple`, `alarm-simultaneous`; 코드에서 busy waiting 제거 확인 |
| 2 | [#37 기본 Priority Scheduling](https://github.com/CatIsApple/PintOS/issues/37) | 상태 전환 이해 후 진행; `priority-fifo`, `priority-preempt`, `priority-change` |
| 3 | [#38 동기화 대기의 우선순위 반영](https://github.com/CatIsApple/PintOS/issues/38) | 기본 우선순위 구현 후; `priority-sema`, `priority-condvar`, `alarm-priority` |
| 4 | [#39 단일·복수 Priority Donation](https://github.com/CatIsApple/PintOS/issues/39) | 기본 우선순위 구현 후; `priority-donate-one`, `priority-donate-multiple`, `priority-donate-multiple2`, `priority-donate-lower` |
| 5 | [#40 중첩·연쇄 Priority Donation](https://github.com/CatIsApple/PintOS/issues/40) | 단일·복수 기부 후; `priority-donate-nest`, `priority-donate-chain`, `priority-donate-sema` |
| 6 | [#41 MLFQS 고정소수점 준비](https://github.com/CatIsApple/PintOS/issues/41) | 팀 공동 설계 후 계산 담당 배정; 고정소수점 연산과 반올림 확인 |
| 7 | [#42 MLFQS 갱신·통합](https://github.com/CatIsApple/PintOS/issues/42) | 계산 준비 후 갱신·통합·검증 담당 배정; 모든 `mlfqs-*` 테스트 |
| 8 | [#43 전체 회귀 테스트와 발표 준비](https://github.com/CatIsApple/PintOS/issues/43) | 두 스케줄러 모드 검증, 발표 자료·개인 WIL·제출 항목 확인 |

환경 구성과 수정 전 기본 실행 결과는 [#6 입문 학습](https://github.com/CatIsApple/PintOS/issues/6)에 기록합니다. 구현에 착수하기 전에 모두 같은 환경에서 빌드할 수 있는지 확인하세요.

`alarm-priority`는 Alarm과 우선순위 구현이 모두 필요합니다. MLFQS는 마지막 날에 몰리지 않도록 명세와 고정소수점 계산을 병행 학습합니다. MLFQS 모드에서는 일반 모드의 수동 우선순위·우선순위 기부 로직이 섞이지 않도록 확인합니다.

## 충돌을 줄이는 방법

`thread.c`, `thread.h`, `synch.c`, `timer.c`는 여러 기능이 함께 수정합니다. 착수할 때 이슈에 **바꿀 파일·추가 필드·함수 인터페이스**를 짧게 적고, 다른 진행 중 이슈와 겹치는지 확인합니다. Alarm과 Priority를 병렬로 맡더라도 공통 필드를 먼저 합의하세요.

매일 시작할 때 10분 동안 어제 결과, 오늘 구현 1개, 막힌 점을 공유합니다. 끝날 때는 PR과 테스트 결과를 확인하고 작은 변경을 통합합니다. 다음 작업을 맡기 전에 이전 작업의 리뷰를 먼저 도와주세요.

## 브랜치와 리뷰

- 개인 작업: `feature/<github-id>/<topic>`; 수정 작업: `fix/<github-id>/<topic>`.
- `main`에서 새 브랜치를 시작하고 의미 있는 작은 단위로 커밋합니다. 다른 사람 브랜치에 강제 push하지 않습니다.
- PR에는 관련 이슈, 변경 이유, 실행한 테스트와 결과를 씁니다. 미구현 기능 때문에 남은 실패는 수정 전 결과와 구분합니다.
- 작성자를 제외한 **팀원 1명 이상의 리뷰** 후 `main`에 병합합니다. 리뷰어는 상태 전환, 리스트 변경, 인터럽트 처리, 테스트 근거 중 변경과 관련된 부분을 확인합니다.
- 현재 비공개 저장소는 GitHub 요금제 제한으로 브랜치 보호를 활성화할 수 없습니다(설정 API에서 403 확인). 리뷰 1명·CI 성공·대화 해결은 팀 운영 규칙으로 지킵니다. 요금제를 변경하지 않았으며, 저장소는 비공개로 유지합니다.

구현 이슈의 완료 조건은 **관련 테스트 근거, 다른 팀원 리뷰, `main` 병합**입니다. CI의 기본 빌드와 `alarm-zero` 성공만으로 전체 기능 완료를 표시하지 않습니다.

## 학습 원칙

요구사항 읽기 → 현재 코드 관찰 → 원하는 상태 변화 그리기 → 직접 구현 → 관련 테스트 → 팀원에게 설명 순서로 반복합니다. 담당 기능이 아니어도 READY와 BLOCKED의 차이, 선점 조건, 기부와 MLFQS 모드의 차이는 모두 설명할 수 있도록 함께 공부합니다.

완성 코드 복사보다 자신의 코드에서 관찰한 내용과 검증 근거를 남깁니다. 리뷰에서 설명하기 어려운 변경은 작게 나누고 동작부터 확인합니다.
