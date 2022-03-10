import 'package:flutter/material.dart';
import 'package:workout_app/pages/home.dart';
import 'package:workout_app/pages/Calendar.dart';
import 'package:workout_app/pages/Dictionary.dart';

void main() {
  runApp(MaterialApp(
      home: WorkoutApp(),
      debugShowCheckedModeBanner: false,
  ));
}

class WorkoutApp extends StatefulWidget {
  @override
  _WorkoutAppState createState() => _WorkoutAppState();
}

class _WorkoutAppState extends State<WorkoutApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(()  {
      _selectedIndex = index;
    });
  }
  final _pages = [
    Home(),
    Calendar(),
    Dictionary()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Center(child: Text("Move It")),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Calendar',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Almanac',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,

      ),
    );
  }
}

