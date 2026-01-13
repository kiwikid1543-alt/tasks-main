import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/data/model/todo_entity.dart';

class TodoRepository {
  // Future<void> addToDo(TodoEntity toDo);
  // Future<void> updateToDo(TodoEntity toDo);
  // Future<void> deleteToDo(String id);

  Future<List<ToDoEntity>?> getToDos() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('todos');
      final result = await collectionRef.get();
      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {'id': doc.id, ...map};
        return ToDoEntity.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 1. 데이터 쓰기
  Future<void> addToDo({
    // 왜 불타입?(인서트, 업데이트, 딜리트), 왜 겓원은 투두엔티티?
    // id는
    required ToDoEntity toDo,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('todos');
      final docRef = collectionRef.doc(toDo.id); // 고유한 id를 자동생성
      await docRef.set(toDo.toJson());
    } catch (e) {
      print(e);
    }
  }

  // 3. 업데이트( 도큐먼트 수정)
  Future<void> updateToDo({
    required String id,
    required String title,
    required String description,
    required bool isFavorite,
    required bool isDone,
  }) async {
    try {
      final fireStore = FirebaseFirestore.instance;
      final collectionRef = fireStore.collection('todos');
      final docRef = collectionRef.doc(id);
      await docRef.update({
        'title': title,
        'description': description,
        'isFavorite': isFavorite,
        'isDone': isDone,
      });
    } catch (e) {
      print(e);
    }
  }

  // 딜리트 (도큐먼트 삭제)
  Future<void> deleteToDo(String id) async {
    try {
      final fireStore = FirebaseFirestore.instance;
      final collectionRef = fireStore.collection('todos');
      final docRef = collectionRef.doc(id);
      await docRef.delete();
    } catch (e) {
      print(e);
    }
  }

  // Stream<List<ToDoEntity>> toDoEntityListStream() {
  //   // Stream,
  //   final fireStore = FirebaseFirestore.instance;
  //   final collectionRef = fireStore.collection('todos');
  //   // snapshots 데이터에 변화가 일어났을 때 값을 하나씩 차곡차곡 넣어주는 역할
  //   final stream = collectionRef.snapshots();
  //   // 변수stream은 쿼리스냅샷 형태여서 List<ToDoEntity>형태로 변환해줘야함
  //   final newStream = stream.map((event) {
  //     //
  //     return event.docs.map((e) {
  //       return ToDoEntity.fromJson({'id': e.id, ...e.data()});
  //     }).toList();
  //     //
  //   });
  //   return newStream;
  // }
  // // listen을 쓸때 통신이 됨

  // Stream<ToDoEntity?> toDoEntitiyStream(String id) {
  //   final fireStore = FirebaseFirestore.instance;
  //   final collectionRef = fireStore.collection('todos');
  //   final docRef = collectionRef.doc(id);
  //   final stream = docRef.snapshots();
  //   final newStream = stream.map((e) {
  //     // doc(id)가 삭제되는 경우가 있기 때문에 아래의 처리를 해줘야함
  //     if (e.data() == null) {
  //       return null;
  //     }
  //     return ToDoEntity.fromJson({'id': e.id, ...e.data()!});
  //   });
  //   return newStream;
  // }
}
