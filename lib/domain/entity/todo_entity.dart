class TodoEntity {
  TodoEntity({
    required this.id,
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
  });
  final String id;
  final String? title;
  final String? description;
  final bool isFavorite;
  final bool isDone;

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isDone,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
    );
  }
}
