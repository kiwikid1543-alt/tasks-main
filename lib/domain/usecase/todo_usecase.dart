import 'package:tasks/domain/entity/todo_entity.dart';
import 'package:tasks/domain/repository/todo_repository.dart';

class TodoUseCase {
  final TodoRepository todoRepository;

  TodoUseCase({required this.todoRepository});

  Future<List<TodoEntity>> getTodo() async {
    return await todoRepository.getTodo();
  }

  Future<TodoEntity> addTodo(TodoEntity todo) async {
    return await todoRepository.addTodo(todo);
  }

  Future<TodoEntity> updateTodo(TodoEntity todo) async {
    return await todoRepository.updateTodo(todo);
  }

  Future<String> deleteTodo(String id) async {
    return await todoRepository.deleteTodo(id);
  }
}
