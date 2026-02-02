import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/data/data_source/todo_data_source.dart';
import 'package:tasks/data/data_source/todo_data_source_impl.dart';
import 'package:tasks/data/repository/todo_repository_impl.dart';
import 'package:tasks/domain/repository/todo_repository.dart';
import 'package:tasks/domain/usecase/todo_usecase.dart';

final todoDataSourceProvider = Provider<TodoDataSource>((ref) {
  return TodoDataSourceImpl();
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final dataSource = ref.watch(todoDataSourceProvider);
  return TodoRepositoryImpl(dataSource: dataSource);
});

final todoUseCaseProvider = Provider<TodoUseCase>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return TodoUseCase(todoRepository: repository);
});
