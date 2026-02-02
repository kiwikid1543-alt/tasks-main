import 'package:tasks/data/dto/todo_dto.dart';

abstract interface class TodoDataSource {
  Future<List<TodoDto>> getTodo();
  Future<TodoDto> addTodo(TodoDto todo);
  Future<TodoDto> updateTodo(TodoDto todo);
  Future<String> deleteTodo(String id);
}
