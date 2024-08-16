import 'dart:convert';
import 'dart:developer';

import 'package:todoo/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:todoo/todo/bloc/todo_bloc.dart';

class TodoRepository {
  final String baseUrl = 'https://dummyjson.com/todos/user/5';

  Future<List<TodoModel>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/todos/user/6'));

    log(response.statusCode.toString());
    log(response.body, name: 'fetchTodos');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((todo) => TodoModel.fromJson(todo)).toList();
      // return TodoLoaded(jsonData.map((todo) => TodoModel.fromJson(todo)).toList());
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<TodoModel> addTodo(TodoModel todo) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'todo': 'New Todo', 'completed': false}),
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<TodoModel> updateTodo(int id, bool completed) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/todos/1'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'todo': 'Updated Todo', 'completed': completed}),
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<TodoModel> deleteTodo(int id) async {
    final response =
        await http.delete(Uri.parse('https://dummyjson.com/todos/1'));
    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
