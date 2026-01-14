import 'package:cloud_firestore/cloud_firestore.dart';
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
    final toDos = await toDoRepo.getToDos();
    state = toDos ?? [];
    // final stream = toDoRepo.toDoEntityListStream();
    // 파이어스토어 데이터베이스 데이터가 변경이 될때마다 감지
    // final streamSubscription = stream.listen((toDos) {
    //   state = toDos; // state 가 ref.watch에 연결되어 있음
    // });

    /// 이 뷰모델이 메모리에서 소거 될때, 넘겨준 함수 호출
    // ref.onDispose(() {
    //   streamSubscription.cancel();
    //   // 구독하고 있는 Sstream의 구독을 끊어주어야 메모리에서 안전하게 제거
    //   // 구독을 끊어주는 방법은 Stream listen 할 때 리턴 받는 StreamSubscription 클래스의
    //   // cancel메서드 호출
    // });
  }

  Future<void> addToDo({
    required String title,
    required String description,
    required bool isFavorite,
  }) async {
    final docId = FirebaseFirestore.instance.collection('todos').doc().id;
    final ToDoEntity newtodo = ToDoEntity(
      id: docId,
      title: title,
      description: description,
      isFavorite: isFavorite,
    );

    await toDoRepo.addToDo(toDo: newtodo);
    state = [...state, newtodo];
  }

  Future<void> deleteToDo({required String id}) async {
    await toDoRepo.deleteToDo(id);
    // 방금 넣은 아이디값할일은 빼고, 나머지 애들만 넣음
    state = state.where((s) => s.id != id).toList();

    // final List<ToDoEntity> newList = [];
    // for (var s in state) {
    //   if (s.id != id) {
    //     newList.add(s);
    //   }
    // }
  }

  Future<void> toggleFavorite({
    required String id,
    required bool isFavorite,
  }) async {
    final todo = state.firstWhere((s) => s.id == id); // ?
    final ToDoEntity newToDo = ToDoEntity(
      id: todo.id, // todo
      title: todo.title, // todo
      isFavorite: isFavorite,
    );
    await toDoRepo.updateToDo(todo: newToDo); // ?
    state = state.map((e) => e.id == id ? newToDo : e).toList();
  }

  Future<void> toggleDone({required String id, required bool isDone}) async {
    final todo = state.firstWhere((e) => e.id == id);
    final ToDoEntity newToDo = ToDoEntity(
      id: todo.id,
      title: todo.title,
      isDone: isDone,
    );
    await toDoRepo.updateToDo(todo: newToDo);
    state = state.map((e) => e.id == id ? newToDo : e).toList();
  }

  // Future<void> toggleDone({required String id, required bool isDone}) {}
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, List<ToDoEntity>>(
  () {
    return HomeViewModel();
  },
);
