import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/data/model/todo_entity.dart';
import 'package:tasks/ui/home/home_view_model.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(homeViewModelProvider);
    final todo = todos.firstWhere((todo) => todo.id == widget.id);
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
            onPressed: () {
              final vm = ref.read(homeViewModelProvider.notifier);
              vm.toggleFavorite(id: todo.id, isFavorite: !todo.isFavorite);
            },
            icon: todo.isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              todo.title ?? '제목없음',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.short_text_rounded),
                ),
                Column(children: [Text(todo.description ?? '내용 없음')]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
