import 'package:flutter/material.dart';
import 'package:todo/views/tasks/Tasks.dart';
import 'package:todo/views/done/Done.dart';
import 'package:todo/views/archived/Archived.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;
  final selectedBackGroundColor = const Color(0xffd52a2f);
  final unselectedBackGroundColor = const Color(0xff3C3C3B);
  final selectedItemColor = Colors.white;
  final unSelectedItemColor = Color.fromARGB(255, 174, 174, 174);

  static const List<Widget> _pages = <Widget>[
    // TabBarComponent(),
    Tasks(),
    Done(),
    Archived()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('title'),
        // ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: SizedBox(
            child: BottomNavigationBar(
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unSelectedItemColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.table_rows_sharp),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archived',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )));
  }
}
