import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/Todo.dart';
import '../views/taskDetails/TaskDetails.dart';

class TaskWidget extends StatelessWidget {
  final Todo task;
  final VoidCallback removeTodo;
  // void Function(String, int)
  final void Function(String, int) toggleStatus;

  const TaskWidget({
    Key? key,
    required this.task,
    required this.removeTodo,
    required this.toggleStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: key,

      // left action pane
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        dismissible: DismissiblePane(onDismissed: () {
          removeTodo();
        }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) => removeTodo(),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // right action pane
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          toggleStatus(task.id, 1); // 1 = done
        }),
        children: [
          SlidableAction(
            onPressed: (context) => toggleStatus(task.id, 2), // 2 = archived
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (context) => toggleStatus(task.id, 1), // 1 = done
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Done',
          ),
        ],
      ),

      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 69, 69, 69),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        child: ListTile(
          // open task details page
          onTap: () {
            // Navigator.pushNamed(context, '/taskDetails', arguments: task);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TaskDetails(task: task);
            }));
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          minLeadingWidth: task.status == 1 ? 0 : 2,
          title: Text(
            task.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            // if description is more than two lines, add '...' at the end.
            task.description.length > 50
                ? '${task.description.substring(0, 50)}...'
                : task.description,
            style: const TextStyle(
              color: Color.fromARGB(255, 143, 143, 143),
              fontSize: 14,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (DateFormat('dd-MM-yyyy').format(DateTime.parse(task.date)) !=
                  DateFormat('dd-MM-yyyy').format(DateTime.now()))
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(task.date)),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 143, 143, 143),
                    fontSize: 14,
                  ),
                ),
              Text(
                DateFormat('hh:mm a').format(DateTime.parse(task.date)),
                style: const TextStyle(
                  color: Color.fromARGB(255, 143, 143, 143),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
