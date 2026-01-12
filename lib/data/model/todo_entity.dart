class ToDoEntity {
  ToDoEntity({
    required this.id,
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
  });
  final String id;
  final String? title;
  final String? description;
  bool isFavorite;
  bool isDone;

  ToDoEntity.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isFavorite: map['isFavorite'] as bool? ?? false,
        isDone: map['isDone'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'isDone': isDone,
    };
  }
}
