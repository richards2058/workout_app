import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';
import 'package:workout_app/components/repsButton.dart';
import 'package:workout_app/pages/workoutDetail.dart';
import 'package:workout_app/components/centerButton.dart';
import 'todaysWorkout.dart';
import 'package:workout_app/db/models/exercise.dart';

class Workout extends StatefulWidget {
  final String packet;

  //construtor
  const Workout({Key? key, required this.packet}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  List _exercise = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/exerciseRecommendation.json');
    final data = await json.decode(response);
    setState(() {
      _exercise = data[widget.packet];
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
          centerTitle: true,
          title: Text("MoveIt"),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                // Use future builder and DefaultAssetBundle to load the local JSON file
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: ListView.builder(
                    // Build the ListView
                    itemCount: _exercise.length,
                    itemBuilder: (BuildContext context, int index) {
                      return reuseableRepsButton(
                        text: _exercise[index]['exerciseName'],
                        reps: _exercise[index]['reps'],
                      );
                    },
                  ),
                ),
              ),
              Container(
                // height: 200,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 226, 224, 224).withOpacity(0.5),
                    spreadRadius: 15,
                    blurRadius: 10,
                    offset: Offset(0, -3), // changes position of shadow
                  ),
                ]),
                child: reuseableCenterButton(
                    text: "Start",
                    onPress: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new workoutDetail(
                                    exerciseList: _exercise,
                                  )));
                    }),
              )
            ],
          ),
        ));
  }
}
