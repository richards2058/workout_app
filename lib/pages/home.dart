import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/components/button.dart';
import 'package:workout_app/pages/Calendar.dart';
import 'package:workout_app/pages/Dummy.dart';
import 'package:workout_app/components/iconButton.dart';
import 'package:workout_app/pages/todaysWorkout.dart';
import 'package:workout_app/db/database_provider.dart';
import 'package:workout_app/db/models/calendarEvent.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);
  bool workoutCompleted = false;
  void getDB(){
    final now =  DateTime.now();
    final  today = now.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
      microseconds: now.microsecond,
    )).toString();
    final String todayString = "${today}Z";
    String packets = "";
    Future<String> TodayPackets = dbHelper.instance.getToday(todayString);
    TodayPackets.then((data) async {
      packets = data.toString();
      List<dynamic> packetList = json.decode(packets);
      if(packetList.isNotEmpty){ workoutCompleted = true;};
    });
  }

  @override
  void initState() {
    getDB();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Move It")),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(0, 100, 200, 1),
                        Colors.lightBlueAccent,
                      ],
                    )),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Hello",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(DateFormat("EEEE, dd MMMM yyyy").format(DateTime.now()),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                )),
            ReuseableIconButton(
              text: "Today's Workout",
              fontSize: 30,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TodaysWorkout()));
              },
              frontIcon: workoutCompleted? Icon(
                Icons.radio_button_checked_outlined,
                size: 40,
                color: Colors.white,
              ) :
              Icon(
                Icons.radio_button_unchecked_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
