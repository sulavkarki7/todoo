class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final bool? isDeleted;
  final String? deletedOn;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    this.isDeleted,
    this.deletedOn,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      isDeleted: json['isDeleted'],
      deletedOn: json['deletedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
    };
  }

  TodoModel copyWith(
    int? id,
    String? todo,
    bool? completed,
  ) {
    return TodoModel(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        completed: completed ?? this.completed);
  }
}
