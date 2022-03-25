import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:workout_app/pages/completedWorkout.dart';
import 'package:workout_app/pages/workout.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';

import '../components/button.dart';

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
        await rootBundle.loadString('assets/exerciseRecommendation.json');
    final data = await json.decode(response);
    setState(() {
      _workoutPacket = data["Workout Packet"].toList();
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
<<<<<<< HEAD
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
                  ],
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: ListView.builder(
                  itemCount: _workoutPacket.length,
                  itemBuilder: (BuildContext context, int index) {
                    return reuseableButton(
                      text: _workoutPacket[index]['packetName'],
=======
      body: Column(
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
                  ReuseableButton(
                      text: "Chest",
>>>>>>> 36c0457c2e6b58347a2ada9b49af6d095f6bc31d
                      onPress: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
<<<<<<< HEAD
                                builder: (BuildContext context) => new Workout(
                                      packet: _workoutPacket[index]
                                          ['packetName'],
                                    )));
                      },
                    );
                  },
                ),
              ),
            )),
          ],
        ),
=======
                                builder: (BuildContext context) =>
                                    new Workout(packet: "Chest & Triceps")));
                      }),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text("Or You can try something else",
                          style: _blueTextStyle)),
                  ReuseableButton(
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
                  ReuseableButton(
                      text: "Completed",
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CompletedWorkout()));
                      }),
                ],
              ))
        ],
>>>>>>> 36c0457c2e6b58347a2ada9b49af6d095f6bc31d
      ),
    );
  }
}
