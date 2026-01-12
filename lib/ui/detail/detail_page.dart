import 'package:flutter/material.dart';
import 'package:tasks/data/model/todo_entity.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.todo});
  final ToDoEntity todo;

  @override
  State<DetailPage> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: widget.todo.isFavorite
                ? Icon(Icons.star)
                : Icon(Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              widget.todo.title ?? '제목없음',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.short_text_rounded),
                ),
                Column(children: [Text(widget.todo.description ?? '내용 없음')]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
