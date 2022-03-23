import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_app/pages/home.dart';
import 'package:workout_app/pages/workout.dart';
import 'package:workout_app/pages/workoutDetail.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';

class TodaysWorkout extends StatefulWidget {
  const TodaysWorkout({Key? key}) : super(key: key);

  @override
  State<TodaysWorkout> createState() => _TodaysWorkoutState();
}

class _TodaysWorkoutState extends State<TodaysWorkout> {
  final _blueTextStyle = const TextStyle(
      color: Colors.blueAccent, fontSize: 20, fontWeight: FontWeight.bold);

  List _workoutPacket = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/exerciseRecomendation.json');
    final data = await json.decode(response);
    setState(() {
      _workoutPacket = data["Workout Packet"];
    });
    // print("check1");
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Today")),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: Text("Today's Workout", style: _blueTextStyle))),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Our Recommendation",
                          style: _blueTextStyle,
                        )),
                    reuseableButton(
                        text: "Chest",
                        onPress: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Workout(packet: "Chest & Triceps")));
                        }),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text("Or You can try something else",
                            style: _blueTextStyle)),
                    reuseableButton(
                        text: "Chest",
                        onPress: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Workout(
                                        packet: "Chest & Triceps",
                                      )));
                        }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
