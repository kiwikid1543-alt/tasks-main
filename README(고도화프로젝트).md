# 📑 Flutter To-Do App 고도화 프로젝트

심화 과정을 통해 배운 클린 아키텍처, 반응형 UI, 그리고 고급 애니메이션을 적용한 고도화된 To-Do 애플리케이션입니다.

## 🚀 주요 기능 및 학습 포인트

### 🏗️ Clean Architecture 리팩토링
- **Layer 분리**: Data, Domain, Presentation 레이어로 나누어 결합도를 낮추고 유지보수성을 향상했습니다.
- **Repository Pattern**: 추상 클래스를 활용하여 데이터 소스(Firestore 등)와의 의존성을 분리했습니다.

### 📱 고도화된 UI/UX
- **Hero Animation**: 리스트에서 상세 화면으로 전환 시 타이틀이 자연스럽게 이동하는 애니메이션 적용.
- **Responsive UI**: 세로/가로 모드 전환 시 레이아웃이 깨지지 않도록 `LayoutBuilder` 및 `MediaQuery` 활용.
- **Advanced List**: `Pull to Refresh` 및 `Infinite Scrolling`(15개 단위 페이징) 구현.

### 🛠️ 성능 및 안정성
- **Debouncing**: 터치 이벤트 중복 발생 방지를 위한 디바운싱 로직 적용.
- **Unit Test**: `fake_cloud_firestore`를 활용한 Repository 단위 테스트 수행.
- **GoRouter**: 선언적 라우팅을 통한 체계적인 페이지 관리.

---

## 🛠 기술 스택
- **Language**: Dart / **Framework**: Flutter
- **State Management**: (사용하신 Provider/Riverpod 등 입력)
- **Database**: Firebase Firestore
- **Navigation**: Go_router

---

## 📸 실행 화면 (예시)
| 메인 리스트 (Infinite Scroll) | Hero 애니메이션 | 반응형 UI (가로모드) |
| :---: | :---: | :---: |
| ![이미지_경로]() | ![이미지_경로]() | ![이미지_경로]() |

---

## 🔥 트러블 슈팅
### 1. Firestore 페이징 처리 이슈
- **문제**: 무한 스크롤 구현 시 데이터가 중복으로 불러와지거나 순서가 섞이는 현상 발생.
- **원인**: 쿼리 시 `startAfterDocument` 기준이 명확하지 않았음.
- **해결**: `createdAt` 필드를 추가하고 최신순 정렬 후, 마지막 문서(DocumentSnapshot)를 저장하여 다음 쿼리의 기점으로 사용함.

### 2. (본인의 추가 트러블 슈팅 사례를 적어주세요)

---

## 📂 프로젝트 구조
lib/
├── core/          # 공통 설정 (Router, Theme, Constants)
├── data/          # Data Source, Repository Implements, Models
├── domain/        # Entities, Repository Interfaces, UseCases
└── presentation/  # UI (Screens, Widgets), ViewModels
