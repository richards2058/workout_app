import 'package:flutter/material.dart';
import 'package:workout_app/db/models/exercise.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:workout_app/components/centerButton.dart';

class workoutDetail extends StatefulWidget {
  final List exerciseList;

  const workoutDetail({Key? key, required this.exerciseList}) : super(key: key);

  @override
  State<workoutDetail> createState() => _workoutDetailState();
}

class _workoutDetailState extends State<workoutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Text("test", style: TextStyle(fontSize: 30))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      "assets/images/Burpees.gif",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text("DESC")),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, -3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left_rounded),
                          color: Colors.blue,
                          iconSize: 70,
                          onPressed: () {},
                        ),
                        Text(
                          "15x3",
                          style: TextStyle(fontSize: 30),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right_rounded),
                          color: Colors.blue,
                          iconSize: 70,
                          onPressed: () {},
                        )
                      ],
                    ),
                    reuseableCenterButton(text: "Next", onPress: () {})
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
