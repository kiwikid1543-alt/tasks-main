import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks/presentation/home/widgets/to_do_widgets.dart';
import 'package:tasks/presentation/home/home_view_model.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(homeViewModelProvider);
    return Expanded(
      // 컬럼에서 남은영역 차지할수있게함
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          // 디바운싱 구현: 탭을 빠르게 두번연속 누르면 두번째 탭이 실행되지 않게 해줌
          return TapDebouncer(
            onTap: () async {
              context.go('/detail/${todos[index].id}');
              await Future.delayed(const Duration(milliseconds: 300));
            },
            builder: (context, onTap) {
              return GestureDetector(
                onTap: onTap,
                child: ToDoWidgets(id: todos[index].id),
              );
            },
          );
        },
      ),
    );
  }
}
