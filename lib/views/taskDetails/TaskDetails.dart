import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/views/tasks/TaskModel.dart';
import 'package:intl/intl.dart';

import '../../models/Todo.dart';
import '../../widgets/FormWidget.dart';
import '../../widgets/TaskWidget.dart';

class TaskDetails extends StatefulWidget {
  final Todo task;
  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        viewModelBuilder: () => TaskModel(),
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                  title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.task.title),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(widget.task.date)) !=
                          DateFormat('dd-MM-yyyy').format(DateTime.now()))
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(widget.task.date)),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 143, 143, 143),
                            fontSize: 14,
                          ),
                        ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(widget.task.date)),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 143, 143, 143),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              )),

              // show task details
              body: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(widget.task.title),
                      subtitle: Text(widget.task.description),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return FormWidget(task: widget.task);
                                });
                          },
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () {
                            model.removeTodo(widget.task.id);
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
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
            ));
  }
}
