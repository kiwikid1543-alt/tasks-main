import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/presentation/detail/detail_page.dart';
import 'package:tasks/presentation/home/widgets/to_do_widgets.dart';
import 'package:tasks/presentation/home/home_view_model.dart';

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(homeViewModelProvider);
    return Expanded(
      // 컬럼에서 남은영역 차지할수있게함
      child: ListView.builder(
        //
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.go('/detail/${todos[index].id}');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return DetailPage(id: todos[index].id);
              //     },
              //   ),
              // );
            },
            child: ToDoWidgets(id: todos[index].id),
          );
        },
      ),
    );
  }
}
