import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/domain/entity/todo_entity.dart';
import 'package:tasks/domain/repository/todo_repository.dart';
import 'package:tasks/providers.dart';

class HomeViewModel extends Notifier<List<TodoEntity>> {
  @override
  List<TodoEntity> build() {
    getAllToDo();
    return [];
  } // 초기값

  // 가져오는거 예상: 가져올때마다 갱신해야

  void getAllToDo() async {
    final useCase = ref.read(todoUseCaseProvider);
    final toDos = await useCase.getTodo();
    state = toDos;
  }

  Future<void> addToDo({
    required String title,
    required String description,
    required bool isFavorite,
  }) async {
    // 1. 임시 엔티티 생성 (아이디는 비워둠)
    final TodoEntity newtodo = TodoEntity(
      id: '', // 뷰모델에서 아이디를 미리 만들지 않음
      title: title,
      description: description,
      isFavorite: isFavorite,
    );
    // 2. usecase를 통해 저장 요청
    final useCase = ref.read(todoUseCaseProvider);

    final result = await useCase.addTodo(newtodo);
    state = [...state, result];
  }

  Future<void> deleteToDo({required String id}) async {
    final useCase = ref.read(todoUseCaseProvider);
    await useCase.deleteTodo(id);
    // 방금 넣은 아이디값할일은 빼고, 나머지 애들만 넣음
    state = state.where((s) => s.id != id).toList();
  }

  Future<void> toggleFavorite({
    required String id,
    required bool isFavorite,
  }) async {
    final todo = state.firstWhere((e) => e.id == id); // ?
    final newToDo = todo.copyWith(isFavorite: isFavorite);
    final useCase = ref.read(todoUseCaseProvider);
    await useCase.updateTodo(newToDo); // ?
    state = state.map((e) => e.id == id ? newToDo : e).toList();
  }

  Future<void> toggleDone({required String id, required bool isDone}) async {
    final todo = state.firstWhere((e) => e.id == id);
    final newToDo = todo.copyWith(isDone: isDone);
    final useCase = ref.read(todoUseCaseProvider);
    await useCase.updateTodo(newToDo);
    state = state.map((e) => e.id == id ? newToDo : e).toList();
  }
}

// NotifierProvider<HomeViewModel, List<ToDoEntity>>
// NotifierProvider: 상태를 저장하고 변경할 수 있는 Notifier 클래스를 관리하는 공급자 타입
// HomeViewModel: 관리할 대상 클래스
// List<ToDoEntity>: HomeViewModel이 최종적으로 관리하고 UI에 전달할 데이터의 타입
final homeViewModelProvider = NotifierProvider<HomeViewModel, List<TodoEntity>>(
  () {
    return HomeViewModel();
  },
);
