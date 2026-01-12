# tasks 앱 구현

1. 프로젝트명: tasks 
2. `lib`에 
            pages
                home
                    widgets
                    home_page.dart 생성
                detail
                    widgets
                    todo_detail_page.dart 생성

3. To Do Entity Class 생성        
    final String title;
    final String? description;
    final bool isFavorite;
    final bool isDone;
        
3. 기본화면 레이아웃 나누기
    <home_page>
    #### appBar
    - title
        - Text


    #### body
    - Column    
        - ContainerBox
            - Column
                - Image
                - Text
                - Text
        - floatingActionButton


    #### bottom

4. 기본화면 home_page 만들기

- title에 ‘수강생 이름`s Tasks’ 넣기
- AppBar title에 사이즈 20, 볼드체 적용 하기
- margin & padding 20 적용하기
- 백그라운드 컬러 및 테두리 라운딩에 circular(12) 적용하기
- Column을 이용하여 수직으로 순서대로 배치(각 요소간 간격 12 설정)
   - 원하는 이미지 (가로&세로 100씩, webp로 변환해서 넣기(Android Studio 사용!) 
   - 텍스트1(사이즈16, 볼드체 적용)
   - 텍스트2(사이즈14, 높이 1.5, 가운데 정렬 적용, AppBar에 적용한 title을 받아 사용)
- Icon 사용하기 (Icon Class의 add icon 사용)
- 아이콘은 흰색, 사이즈 24, 배경은 원하는 색상, 버튼 모양은 원형 적용
- 눌렀을 때 작동 될 addTodo 함수 작성 및 위젯에 연결

5. To Do가 추가 된 화면 만들기

- ToDoEntity 를 인자로 받는 ToDoView 위젯 만들기 
   - 마진 수직 8, 패딩 수평 16, 라운딩 12, 내부 요소들 간 간격 12으로 구현
      - Icon(circle & check_circle) : 버튼이 눌렸을 때 Done 상태 변경
      - 텍스트(To Do의 title) : Done 상태에 따라서 취소선 상태 적용
      - Icon(star & star_border) : 버튼이 눌렸을 때 Favorite 상태 변경
   - ToDo 객체를 외부에서 받아오므로, 이를 수정할 수 있는 함수 또한 외부에서 받아야 합니다.
     (VoidCallback 을 인자로 받으세요!)
- To Do가 없을 때는 처음 만들었던 NoToDo(3번에서 만든 위젯)를, 
   있을 때는 ToDoView가 리스트 뷰를 이용해서 화면에 표시되도록 구현

6. To Do 상세 보기 화면 만들기

- AppBar에 leading과 actions 사용하기
- back button을 통해서 뒤로가기 구현하기
- favorite 변경 구현하기(현재 페이지, 뒤로 간 페이지 모두 반영되어야 합니다.)
- ToDoEntity를 받아서 화면 컨텐츠 채우기