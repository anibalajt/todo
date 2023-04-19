import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/views/tasks/TaskModel.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../models/Todo.dart';

class FormWidget extends StatelessWidget {
  final Todo? task;
  String _title = '';
  String _description = '';
  DateTime _date = DateTime.now();
  bool _dateUpdated = false;
  FormWidget({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
      viewModelBuilder: () => TaskModel(),
      builder: (context, model, _) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        title: const Text('New Task'),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: task?.title ?? ''),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller:
                    TextEditingController(text: task?.description ?? ''),
                maxLines: 8,
                minLines: 2,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Sub Task',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              // add date field to the form.
              DateTimeFormField(
                dateFormat: DateFormat('dd/MM/yyyy hh:mm a'),
                // add initial value from task
                initialValue: task?.date != null
                    ? DateTime.parse(task!.date)
                    : DateTime.now(),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  hintText: 'Due Date',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) =>
                    (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  _date = value;
                  _dateUpdated = true;
                },
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: const Color(0xff2da9ef),
              ),
              onPressed: () {
                if (task != null) {
                  model.updateTodo(
                    task!.id,
                    _title != '' ? _title : task!.title,
                    _description != '' ? _description : task!.description,
                    _dateUpdated ? _date : DateTime.parse(task!.date),
                  );
                } else {
                  model.addTodo(
                    _title,
                    _description,
                    _date,
                  );
                }

                Navigator.of(context).pop();
              },
              child: Text(
                // show add or update depending on the task
                task?.id != null ? 'Update' : 'Add',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
