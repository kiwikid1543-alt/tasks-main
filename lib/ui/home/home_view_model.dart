import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/data/model/todo_entity.dart';
import 'package:tasks/data/repository/todo_repository.dart';

class HomeViewModel extends Notifier<List<ToDoEntity>> {
  @override
  List<ToDoEntity> build() {
    getAllToDo();
    return [];
  } // 초기값

  // 가져오는거 예상: 가져올때마다 갱신해야
  final toDoRepo = TodoRepository();

  void getAllToDo() async {
    // final toDos = await toDoRepo.getToDos();
    // state = toDos ?? [];
    final stream = toDoRepo.toDoEntityListStream();
    // 파이어스토어 데이터베이스 데이터가 변경이 될때마다 감지
    final streamSubscription = stream.listen((toDos) {
      state = toDos;
    });

    /// 이 뷰모델이 메모리에서 소거 될때, 넘겨준 함수 호출
    ref.onDispose(() {
      streamSubscription.cancel();
      // 구독하고 있는 Sstream의 구독을 끊어주어야 메모리에서 안전하게 제거
      // 구독을 끊어주는 방법은 ㄴStream listen 할 때 리턴 받는 StreamSubscription 클래스의
      // cancel메서드 호출
    });
  }

  Future<void> addToDo({required ToDoEntity toDo}) async {
    toDoRepo.addToDo(toDoEntity: toDo);
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, List<ToDoEntity>>(
  () {
    return HomeViewModel();
  },
);
