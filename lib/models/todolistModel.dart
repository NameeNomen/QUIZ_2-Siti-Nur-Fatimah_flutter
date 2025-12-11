// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  // Properti setiap item Todo
  final int id;         // id Todo [cite: 28]
  final String todo;    // Teks pekerjaan [cite: 29]
  final bool completed; // Status selesai (true/false) [cite: 30]
  final int userId;     // ID user yang memiliki todo [cite: 31]

  // 1. CONSTRUCTOR
  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Todo copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      todo: map['todo'] as String,
      completed: map['completed'] as bool,
      userId: map['userId'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  // }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.todo == todo &&
      other.completed == completed &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      todo.hashCode ^
      completed.hashCode ^
      userId.hashCode;
  }
}
