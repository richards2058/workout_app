import 'package:flutter/material.dart';
import 'package:workout_app/pages/home.dart';
import 'package:workout_app/pages/Calendar.dart';
import 'package:workout_app/pages/Dictionary.dart';
import 'package:workout_app/nav/tab_navigator.dart';

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
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", "Calendar", "Dictionary"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Calendar": GlobalKey<NavigatorState>(),
    "Dictionary": GlobalKey<NavigatorState>(),
  };

  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();

        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Home"),
          _buildOffstageNavigator("Calendar"),
          _buildOffstageNavigator("Dictionary"),
        ]),
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
              label: 'Dictionary',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
