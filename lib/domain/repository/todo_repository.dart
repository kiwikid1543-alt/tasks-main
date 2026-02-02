import 'package:tasks/domain/entity/todo_entity.dart';

abstract interface class TodoRepository {
  Future<List<TodoEntity>> getTodo();
  Future<TodoEntity> addTodo(TodoEntity todo);
  Future<TodoEntity> updateTodo(TodoEntity todo);
  Future<String> deleteTodo(String id);
}
