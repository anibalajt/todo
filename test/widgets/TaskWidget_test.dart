import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/widgets/TaskWidget.dart';
import 'package:todo/models/Todo.dart';

void main() {
  testWidgets('Task widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: TaskWidget(
        task: Todo(
            id: '1',
            title: 'Test Task',
            description: 'Test Description',
            date: '2022-09-14 19:39:00.000',
            status: 0),
        removeTodo: () {},
        toggleStatus: (String, int) {},
      ),
    ));

    // Verify that our task title is displayed
    expect(find.text('Test Task'), findsOneWidget);
    // Verify that our task description is displayed
    expect(find.text('Test Description'), findsOneWidget);
    // Verify that our task date is displayed
    expect(find.text('07:39 PM'), findsOneWidget);
  });
}
