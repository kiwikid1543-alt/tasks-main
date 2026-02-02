import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/presentation/home/widgets/not_todo.dart';
import 'package:tasks/presentation/home/widgets/plus_todo.dart';
import 'package:tasks/presentation/home/widgets/todo_view.dart';
import 'package:tasks/presentation/home/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final String appName = '동준`s Tasks';

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //  빈 화면 누르면 키보드 닫히게, 이거 없어도 왜 닫히나?
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
              //
              context: context,
              builder: (context) {
                return Plustodo(); // 바텀시트와 연결
              },
            );
          }, //
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 24,
          ), // 왜 마지막으로 오게해야? -> 차일드의 차일드 계속 이어질 수 있어 혼잡방지
        ),

        backgroundColor: Colors.grey.shade400, // Scaffold에서 배경색 지정
        appBar: AppBar(
          title: Text(
            appName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          // 리스트뷰 사용
          children: [
            // 컨테이너 만들고 속성 주기
            homeState.isEmpty
                ? NotTodo(appName: appName)
                // ToDo 추가된 화면 만들기
                : TodoView(),
          ],
        ),
      ),
    );
  }
}
