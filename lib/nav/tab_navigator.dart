import 'package:flutter/material.dart';
import 'package:workout_app/pages/home.dart';
import 'package:workout_app/pages/Calendar.dart';
import 'package:workout_app/pages/database.dart';
import 'package:workout_app/pages/Dictionary.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = Home();
    if (tabItem == "Home") {
      child = Home();
    } else if (tabItem == "Calendar") {
      child = Calendar();
    } else if (tabItem == "Dictionary") {
      child = Dictionary();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
