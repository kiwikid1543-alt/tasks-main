import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDto {
  TodoDto({
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
  bool isFavorite;
  bool isDone;
  DateTime? createdAt;

  TodoDto copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TodoDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  TodoDto.fromJson(Map<String, dynamic> map)
    : this(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isFavorite: map['isFavorite'] as bool? ?? false,
        isDone: map['isDone'] as bool? ?? false,
        createdAt: map['createdAt'] != null
            ? (map['createdAt'] as Timestamp).toDate()
            : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'isDone': isDone,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
