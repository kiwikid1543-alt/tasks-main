import 'package:tasks/data/data_source/todo_data_source.dart';
import 'package:tasks/data/dto/todo_dto.dart';
import 'package:tasks/domain/entity/todo_entity.dart';
import 'package:tasks/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl({required this.dataSource});

  @override
  Future<List<TodoEntity>> getTodo() async {
    final dtos = await dataSource.getTodo();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<TodoEntity> addTodo(TodoEntity todo) async {
    final dto = await dataSource.addTodo(todo.toDto());
    return dto.toEntity();
  }

  @override
  Future<TodoEntity> updateTodo(TodoEntity todo) async {
    final dto = await dataSource.updateTodo(todo.toDto());
    return dto.toEntity();
  }

  @override
  Future<String> deleteTodo(String id) async {
    return await dataSource.deleteTodo(id);
  }
}

extension on TodoDto {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite,
      isDone: isDone,
      createdAt: createdAt,
    );
  }
}

extension on TodoEntity {
  TodoDto toDto() {
    return TodoDto(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite,
      isDone: isDone,
      createdAt: createdAt,
    );
  }
}
