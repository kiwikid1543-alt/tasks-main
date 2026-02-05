class TodoEntity {
  TodoEntity({
    required this.id,
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
    this.createdAt,
  });
  final String id;
  final String? title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
  final DateTime? createdAt;

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
