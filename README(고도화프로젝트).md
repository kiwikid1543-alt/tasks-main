# 📑 Flutter To-Do App 고도화 프로젝트

심화 과정을 통해 배운 클린 아키텍처, 반응형 UI, 그리고 고급 애니메이션을 적용한 고도화된 To-Do 애플리케이션입니다.

## 🚀 주요 기능 및 학습 포인트

### 🏗️ Clean Architecture 리팩토링
- **Layer 분리**: Data, Domain, Presentation 레이어로 나누어 결합도를 낮추고 유지보수성을 향상했습니다.
- **Repository Pattern**: 추상 클래스를 활용하여 데이터 소스(Firestore 등)와의 의존성을 분리했습니다.

### 📱 고도화된 UI/UX
- **Hero Animation**: 리스트에서 상세 화면으로 전환 시 타이틀이 자연스럽게 이동하는 애니메이션 적용.

### 🛠️ 성능 및 안정성
- **Debouncing**: 터치 이벤트 중복 발생 방지를 위한 디바운싱 로직 적용.
- **GoRouter**: 선언적 라우팅을 통한 체계적인 페이지 관리.

---

## 🛠 기술 스택
- **Language**: Dart / **Framework**: Flutter
- **State Management**: Riverpod
- **Database**: Firebase Firestore
- **Navigation**: Go_router

---

## 📂 프로젝트 구조
lib/
├── core/          # 공통 설정 (Router, Theme, Constants)
├── data/          # Data Source, Repository Implements, Models
├── domain/        # Entities, Repository Interfaces, UseCases
└── presentation/  # UI (Screens, Widgets), ViewModels
