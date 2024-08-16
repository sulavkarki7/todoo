import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:todoo/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // final TodoRepository todoRepository;
  TodoBloc() : super(TodoInitial()) {
    on<FetchTodosEvent>(_fetchTodos);
    on<AddTodoEvent>(_addTodo);
    on<UpdateTodosEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
  }

  FutureOr<void> _fetchTodos(
      FetchTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/todos'));
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> todosJson = jsonData['todos'];
        final List<TodoModel> todos =
            todosJson.map((todo) => TodoModel.fromJson(todo)).toList();
        emit(TodoLoaded(todos));
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (e) {
      emit(TodoError('Failed to load todos'));
    }
  }

  FutureOr<void> _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      final response = await http.post(
          Uri.parse('https://dummyjson.com/todos/add'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'todo': 'New Todo', 'completed': false}));

      log(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final TodoModel newTodo = TodoModel.fromJson(jsonData);
        if (state is TodoLoaded) {
          final List<TodoModel> updatedTodos =
              List.from((state as TodoLoaded).todos)..add(newTodo);
          emit(TodoLoaded(updatedTodos));
        }
        add(FetchTodosEvent());
      } else {
        throw Exception('Failed to add todoss');
      }
    } catch (e) {
      emit(TodoError('Failed to add todo'));
    }
  }

  FutureOr<void> _updateTodo(
      UpdateTodosEvent event, Emitter<TodoState> emit) async {
    try {
      final response = await http.put(
          Uri.parse('https://dummyjson.com/todos/${event.id}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'completed': event.completed}));

      if (response.statusCode == 200) {
        final List<TodoModel> updatedTodos =
            (state as TodoLoaded).todos.map((todo) {
          // if (todo.id == event.id) {
          // return todo.copyWith(completed: event.completed);
          // return todo.copyWith(completed: event.completed);
          // }
          return todo;
        }).toList();
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      emit(TodoError('Failed to update todo'));
    }
  }

  FutureOr<void> _deleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    // try {
    //   await todoRepository.deleteTodo(event.id);
    //   emit(TodoDeleted());
    // } catch (e) {
    //   emit(TodoError('Failed to delete todo'));
    // }
  }
}
