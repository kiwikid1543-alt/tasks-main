import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/data/data_source/todo_data_source.dart';
import 'package:tasks/data/dto/todo_dto.dart';

class TodoDataSourceImpl implements TodoDataSource {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<List<TodoDto>> getTodo() async {
    try {
      final collectionRef = _firestore.collection('todos');
      final result = await collectionRef.get();
      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return TodoDto.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 1. 데이터 쓰기
  @override
  Future<TodoDto> addTodo(TodoDto todo) async {
    try {
      final collectionRef = _firestore.collection('todos');

      final docRef = todo.id.isEmpty
          ? collectionRef
                .doc() //  고유한 id를 자동생성
          : collectionRef.doc(todo.id);

      final updatedTodo = todo.copyWith(id: docRef.id); // ?
      await docRef.set(updatedTodo.toJson());
      return updatedTodo;
    } catch (e) {
      print('AddTodo Error: $e');
      rethrow;
    }
  }

  // 3. 업데이트( 도큐먼트 수정)
  @override
  Future<TodoDto> updateTodo(TodoDto todo) async {
    try {
      final docRef = _firestore.collection('todos').doc(todo.id);
      await docRef.update(todo.toJson());
      return todo;
    } catch (e) {
      print(e);
      rethrow; // ?
    }
  }

  // 딜리트 (도큐먼트 삭제)
  @override
  Future<String> deleteTodo(String id) async {
    try {
      final docRef = _firestore.collection('todos').doc(id);
      await docRef.delete();
      return id;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
