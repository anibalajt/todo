import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:stacked/stacked.dart';

import '../constants/app_constants.dart';
import '../models/Todo.dart';

class ApiService with ReactiveServiceMixin {
  Client client = Client();

  // late final http.Client client = http.Client();

  Future<List<Todo>> fetchTodos() async {
    final response = await client.get(Uri.parse(AppConstants.apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (task) => Todo(
              id: task['id'],
              title: task['title'],
              date: task['date'],
              description: task['description'],
              status: task['status'],
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<String> addTodo(Todo todo) async {
    final url = Uri.parse(AppConstants.apiUrl);
    final response = await client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': todo.title,
        'description': todo.description,
        'date': todo.date,
        'status': todo.status,
      }),
    );

    // return the id coming from the server
    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    } else {
      throw Exception('Failed to add todo');
    }
  }

  // update todo
  Future<void> updateTodo(String id, String title, String description,
      String date, int status) async {
    const apiUrl = AppConstants.apiUrl;
    final url = Uri.parse('$apiUrl/$id');
    final response = await client.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'description': description,
        'date': date,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // delete todo
  Future<void> deleteTodoById(String id) async {
    const apiUrl = AppConstants.apiUrl;
    final url = Uri.parse('$apiUrl/$id');
    final response = await client.delete(url);

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
