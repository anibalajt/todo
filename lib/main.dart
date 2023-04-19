import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/bottomNavBar.dart';

import 'locator.dart';
import 'models/Todo.adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox('todos');

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData.dark(),
        home: const Align(
          alignment: Alignment.topLeft, // and bottomLeft
          child: SafeArea(
              bottom: false,
              child: Scaffold(
                body: BasicBottomNavBar(),
              )),
        ));
  }
}
