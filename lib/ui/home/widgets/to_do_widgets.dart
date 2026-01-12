import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/data/model/todo_entity.dart';
import 'package:tasks/data/repository/todo_repository.dart';
import 'package:tasks/ui/home/home_view_model.dart';

class ToDoWidgets extends ConsumerWidget {
  ToDoWidgets({super.key, required this.id}); // const 빼야하나?
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(homeViewModelProvider);
    final todo = todos.firstWhere((todo) => todo.id == id);

    return Container(
      // 2번째 체크박스
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ), // 패딩 수평 16(과제조건)

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: [
          // 아이콘과 텍스트 가로로 배치되어 있음
          GestureDetector(
            onTap: () {},
            child: Container(
              //체크하는 동그라미
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),

                // color: Colors.black, //삼항연산자
              ),
              child: todo.isDone
                  ? Icon(Icons.check, color: Colors.grey.shade300, size: 20)
                  : null,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              todo.title ?? '',
              style: TextStyle(
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ), // 글자 안넘치게 방지하기 위해 expanded 사용
          GestureDetector(
            onTap: () {},
            child: todo.isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
          ),
          SizedBox(width: 20),
          GestureDetector(onTap: () {}, child: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
