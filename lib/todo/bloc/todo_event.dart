part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class FetchTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoModel todo;

  AddTodoEvent(
    this.todo,
  );
}

class UpdateTodosEvent extends TodoEvent {
  final int id;
  final bool completed;

  UpdateTodosEvent(this.id, this.completed);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  DeleteTodoEvent(this.id);
}
