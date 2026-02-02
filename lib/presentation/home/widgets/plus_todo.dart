import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/presentation/home/home_view_model.dart';

class Plustodo extends ConsumerStatefulWidget {
  const Plustodo({super.key});

  @override
  ConsumerState<Plustodo> createState() => _PlustodoState();
}

class _PlustodoState extends ConsumerState<Plustodo> {
  bool isFavorite = false;
  bool isDiscription = false;
  bool isTitleEmpty = true;

  TextEditingController controller = TextEditingController(); // ??
  TextEditingController controller2 = TextEditingController();

  // 유효성검사, 데이터저장, 초기화 등, 입력값등을 동시제어
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isTitleEmpty = controller.text.trim().isEmpty;
      });
    });
  }

  void saveTodo() {
    if (isTitleEmpty) {
      return;
    }
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    homeViewModel.addToDo(
      title: controller.text,
      description: controller2.text,
      isFavorite: isFavorite,
    );

    Navigator.of(context).pop(); // 쌓인 걸 나가준다.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + 5, //바텀시트가 키보드 위로 잡히도록
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            style: TextStyle(fontSize: 15),
            autofocus: true, // 별도의 클릭없이 즉시 해당입력창에 포커스를 주고 키보드를 활성화
            maxLines: 1, // 개행이 안되게
            onSubmitted: (value) {
              // 엔터나 완료를 눌러도 출력되게 만들어줌
              saveTodo();
            },

            decoration: InputDecoration(hintText: "새 할일"),
          ),
          if (isDiscription)
            Flexible(
              child: TextField(
                controller: controller2,
                style: TextStyle(fontSize: 15),
                autofocus: true, // 별도의 클릭없이 즉시 해당입력창에 포커스를 주고 키보드를 활성화
                maxLines: 5, // 개행이 안되게
                minLines: 1,
                onSubmitted: (value) {
                  saveTodo();
                },
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(hintText: "세부사항"),
              ),
            ),
          Row(
            children: [
              /// 설명 Icon을 눌렀을 때 description용 TextField 보이게 하기
              IconButton(
                onPressed: () {
                  isDiscription = !isDiscription;

                  setState(() {});
                  //함수를 호출해서 새로운 TextField 만들기: 어떻게?
                },
                icon: Icon(Icons.short_text_rounded, size: 24),
              ),
              // 삼항연산자
              IconButton(
                onPressed: () {
                  isFavorite = !isFavorite;

                  setState(() {});
                },
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border, // isFavorite
                  size: 24,
                ),
              ),
              Spacer(),
              // 텍스트를 텍스트버튼으로 만들어서 '저장'을 누르면 저장되게 함
              TextButton(
                onPressed: isTitleEmpty ? null : saveTodo,
                child: Text('저장'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
