// stateless component for Tasks page
// get the model from the Home page

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/views/tasks/TaskModel.dart';

import '../../widgets/FormWidget.dart';
import '../../widgets/TaskWidget.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
      viewModelBuilder: () => TaskModel(),
      builder: (context, model, _) => Scaffold(
        // appBar: AppBar(title: const Text('Flutter Stacked Todos')),
        body: ListView.separated(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          itemBuilder: (context, index) {
            return TaskWidget(
              key: ValueKey(model.todos[index].id),
              task: model.todos[index],
              removeTodo: () => model.removeTodo(model.todos[index].id),
              toggleStatus: model.toggleStatus,
            );
          },
          itemCount: model.todos.length,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 4,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FormWidget();
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
