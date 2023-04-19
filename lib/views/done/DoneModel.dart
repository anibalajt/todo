import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../models/Todo.dart';
import '../../services/Todos.service.dart';

class DoneModel extends ReactiveViewModel {
  final _todosService = locator<TodosService>();
  // Change task status
  late final toggleStatus = _todosService.toggleStatus;
  // Remove task
  late final removeTodo = _todosService.removeTodo;

  // This method returns all the todos that are done
  List<Todo> get todos => _todosService.doneTodos;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_todosService];
}
