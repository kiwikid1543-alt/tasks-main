## 🛣️  과제 시작 및 구현 순서 가이드

어디서부터 손을 대야 할지 막막하시죠? 아래 순서대로 진행하는 것을 추천합니다.

### **Step 1: 클린 아키텍처 구조 잡기 (가장 먼저!)**
기존 코드를 바로 수정하기보다, 폴더 구조를 먼저 만드세요.
1. `lib/core`, `lib/data`, `lib/domain`, `lib/presentation` 폴더를 생성합니다.
2. `domain` 레이어에 **Repository 인터페이스(abstract class)**를 먼저 정의하세요. 이것이 앱의 설계도입니다.

### **Step 2: 라우팅 및 기본 이동 (GoRouter)**
1. `GoRouter`를 `core/router.dart`에 설정합니다.
2. 기존의 `Navigator.push`를 모두 `context.go()` 또는 `context.push()`로 교체합니다.

### **Step 3: UI 고도화 (Hero & 반응형)**
1. **Hero**: 리스트의 Item 위젯과 상세 페이지의 타이틀 위젯을 `Hero` 위젯으로 감싸고 동일한 `tag`를 부여하세요.
2. **반응형**: 메인 화면을 `OrientationBuilder`로 감싸서 가로 모드일 때 컬럼 개수를 조절하거나 패딩을 조절해 봅니다.

### **Step 4: 비즈니스 로직 고도화 (Infinite Scroll & Debouncing)**
1. Firestore 쿼리에 `limit(15)`를 걸고, `ScrollController`를 사용해 바닥에 닿았을 때 추가 데이터를 호출합니다.
2. 버튼 클릭 시 `Timer`를 활용하거나 패키지를 사용해 디바운싱을 적용합니다.

### **Step 5: 테스트 및 배포 준비**
1. `test/` 폴더 내에 Mock 데이터를 활용한 테스트 코드를 작성합니다.
2. 안드로이드 빌드 설정을 확인합니다.

---

**💡 팁:** 클린 아키텍처가 처음엔 복잡해 보이지만, **"UI는 데이터가 어디서 오는지 몰라도 된다"**는 원칙만 기억합니다

삭제 팝업