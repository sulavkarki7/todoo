part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class TaskTileTapped extends HomeEvent {
  final Task task;

  TaskTileTapped(this.task);
}

class RemoveTask extends HomeEvent {
  final Task task;

  RemoveTask(this.task);
}

class EditTask extends HomeEvent {
  final Task task;

  EditTask(this.task);
}
