import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../models/Todo.dart';
import 'Api.service.dart';

class TodosService with ReactiveServiceMixin {
  final apiService = ApiService();
  //get todos from apiservice and save to hive
  TodosService() {
    listenToReactiveValues([_todos]);
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    _todos.value = await apiService.fetchTodos();
    // save to hive
    _saveToHive();
  }

  final _todos = ReactiveValue<List<Todo>>(
    Hive.box('todos').get('todos', defaultValue: []).cast<Todo>(),
  );

  final _random = Random();

  // get all tasks no Done 0
  List<Todo> get todos =>
      _todos.value.where((todo) => todo.status == 0).toList(growable: false);

  // get all tasks Done 1
  List<Todo> get doneTodos =>
      _todos.value.where((todo) => todo.status == 1).toList(growable: false);

  // get all tasks Archive 2
  List<Todo> get archiveTodos =>
      _todos.value.where((todo) => todo.status == 2).toList(growable: false);

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  void _saveToHive() => Hive.box('todos').put('todos', _todos.value);

  Future<void> toggleStatus(String id, int status) async {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value[index].status = status;

      _saveToHive();
      notifyListeners();

      // update todo
      await apiService.updateTodo(
        id,
        _todos.value[index].title,
        _todos.value[index].description,
        _todos.value[index].date.toString(),
        _todos.value[index].status,
      );
    }
  }

  Future<bool> removeTodo(String id) async {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value.removeAt(index);
      _saveToHive();
      notifyListeners();

      // delete todo
      await apiService.deleteTodoById(id);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTodo(
      String id, String title, String description, DateTime date) async {
    final index = _todos.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos.value[index].title = title;
      _todos.value[index].description = description;
      _todos.value[index].date = date.toString();

      _saveToHive();
      notifyListeners();

      // update todo in server
      await apiService.updateTodo(
        id,
        title,
        description,
        date.toString(),
        _todos.value[index].status,
      );

      return true;
    } else {
      return false;
    }
  }

  Future<void> addTodo(String title, String description, DateTime date) async {
    // create a new todo

    final todo = Todo(
      id: _randomId(),
      title: title,
      description: description,
      // convert date to string
      date: date.toString(),
    );

    // save todo in server
    final id = await apiService.addTodo(todo);
    todo.id = id;

    // insert the new todo at the beginning of the list
    _todos.value.insert(0, todo);

    // save the new list to hive
    _saveToHive();

    // notify listeners
    notifyListeners();
  }
}
