import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/domain/entity/todo_entity.dart';
import 'package:tasks/providers.dart';

class HomeViewModel extends Notifier<List<TodoEntity>> {
  Timer? _debouncer;
  @override
  List<TodoEntity> build() {
    getAllToDo();
    return [];
  } // 초기값

  // 가져오는거 예상: 가져올때마다 갱신해야

  void getAllToDo() async {
    try {
      final useCase = ref.read(todoUseCaseProvider);
      final toDos = await useCase.getTodo();
      state = toDos;
    } catch (e) {
      print('getAllToDo Error: $e');
    }
  }

  Future<void> addToDo({
    required String title,
    required String description,
    required bool isFavorite,
  }) async {
    try {
      // 1. 임시 엔티티 생성 (아이디는 비워둠)
      final TodoEntity newtodo = TodoEntity(
        id: '', // 뷰모델에서 아이디를 미리 만들지 않음
        title: title,
        description: description,
        isFavorite: isFavorite,
        createdAt: DateTime.now(),
      );
      // 2. usecase를 통해 저장 요청
      final useCase = ref.read(todoUseCaseProvider);

      final result = await useCase.addTodo(newtodo);
      state = [...state, result];
    } catch (e) {
      print('addToDo Error: $e');
    }
  }

  // 삭제 하고 일정시간동안 취소할 수 있도록 구현, 크롬에서 처럼
  Future<void> deleteToDo({required String id}) async {
    try {
      final useCase = ref.read(todoUseCaseProvider);
      await useCase.deleteTodo(id);
      // 방금 넣은 아이디값할일은 빼고, 나머지 애들만 넣음
      state = state.where((s) => s.id != id).toList();
    } catch (e) {
      print('deleteToDo Error: $e');
    }
  }

  Future<void> toggleFavorite({
    required String id,
    required bool isFavorite,
  }) async {
    // 이전 상태 백업
    final oldState = state;
    // 서버 응답 기다리지 않고 UI부터 먼저 변경
    final todo = state.firstWhere((e) => e.id == id); // ?
    final newToDo = todo.copyWith(isFavorite: isFavorite);
    state = state.map((e) => e.id == id ? newToDo : e).toList();
    // 디바운싱: 0.5초 이내의 추가 클릭은 무시하고 마지막 한번만 서버에 전송
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () async {
      try {
        await ref.read(todoUseCaseProvider).updateTodo(newToDo);
      } catch (e) {
        // 서버 저장 실패시 백업본을 원상복구
        state = oldState;
        print('toggleFavorite 서버 업데이트 오류: $e');
      }
    });
  }

  Future<void> toggleDone({required String id, required bool isDone}) async {
    final oldState = state;
    final todo = state.firstWhere((e) => e.id == id);
    final newToDo = todo.copyWith(isDone: isDone);
    state = state.map((e) => e.id == id ? newToDo : e).toList();
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () async {
      try {
        await ref.read(todoUseCaseProvider).updateTodo(newToDo);
      } catch (e) {
        state = oldState;
        print('toggleDone 서버 업데이트 오류: $e');
      }
    });
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
