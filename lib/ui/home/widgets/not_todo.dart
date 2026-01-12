import 'package:flutter/material.dart';

class NotTodo extends StatelessWidget {
  const NotTodo({super.key, required this.appName});

  final String appName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        // 컨테이너에서 차일드로 컬럼 주고 그 안에 칠드런 해서 각종 아이콘, 텍스트 넣기
        // Container에 child 속성을 사용하여 Column을 사용, 그 다음 children
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.asset(
                'assets/image.png',
                fit: BoxFit.cover,
              ), // fit: BoxFit.cover 이미지 꽉차게
            ), // image를 추가할 때 pubspec.yaml에 경로를 추가해야함
          ),
          SizedBox(height: 12),
          Text(
            textAlign: TextAlign.center,
            '아직 할 일이 없음',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            textAlign: TextAlign.center,
            '할 일을 추가하고 $appName에서\n 할 일을 추적하세요.',
            style: TextStyle(fontSize: 14, height: 1.5), // 높이? 미묘한 디자인
          ),
        ],
      ),
    );
  }
}
