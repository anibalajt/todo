import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../models/Todo.dart';
import '../../services/Todos.service.dart';

class TaskModel extends ReactiveViewModel {
  final _firstTodoFocusNode = FocusNode();
  final _todosService = locator<TodosService>();
  late final toggleStatus = _todosService.toggleStatus;
  late final removeTodo = _todosService.removeTodo;
  late final updateTodo = _todosService.updateTodo;
  late final addTodo = _todosService.addTodo;

  List<Todo> get todos => _todosService.todos;

  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_todosService];
}
