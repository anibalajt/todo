import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo/views/done/DoneModel.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoneModel>.reactive(
      viewModelBuilder: () => DoneModel(),
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
                    // description for tasks done no yet
                    Text('No Tasks Done yet.'),
                  ],
                ),
              ),
            ...model.todos.map((todo) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    todo.status == 1 ? Icons.task_alt : Icons.circle_outlined,
                  ),
                  onPressed: () => model.toggleStatus(todo.id, 0),
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
