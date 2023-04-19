import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/views/archived/ArchivedModel.dart';

class Archived extends StatefulWidget {
  const Archived({Key? key}) : super(key: key);

  @override
  State<Archived> createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArchivedModel>.reactive(
      viewModelBuilder: () => ArchivedModel(),
      builder: (context, model, _) => Scaffold(
        // appBar: AppBar(title: const Text('Flutter Stacked Todos')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.todos.isEmpty)
              Opacity(
                opacity: 0.5,
                child: Column(
                  children: const [
                    SizedBox(height: 64),
                    Icon(Icons.emoji_food_beverage_outlined, size: 48),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ...model.todos.map((todo) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    todo.status == 1 ? Icons.task_alt : Icons.circle_outlined,
                  ),
                  onPressed: () => model.toggleStatus(todo.id, 1),
                ),
                // show title and description in Texts.
                title: Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 20,
                    decoration:
                        todo.status == 1 ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  todo.description,
                  style: TextStyle(
                    fontSize: 14,
                    decoration:
                        todo.status == 1 ? TextDecoration.lineThrough : null,
                  ),
                ),

                trailing: IconButton(
                  icon: const Icon(Icons.horizontal_rule),
                  onPressed: () => model.removeTodo(todo.id),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
