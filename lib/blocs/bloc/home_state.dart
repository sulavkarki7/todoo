part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class TaskLoading extends HomeState {}

final class TaskLoaded extends HomeState {
  final List<Task> tasks;

  TaskLoaded({this.tasks = const []});
}

final class TaskError extends HomeState {
  final String message;

  TaskError(this.message);
}
