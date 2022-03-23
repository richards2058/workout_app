import 'package:flutter/material.dart';
import 'package:workout_app/db/models/exercise.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class exerciseDetail extends StatefulWidget {
  final exercise currentexercise;

  const exerciseDetail({Key? key, required this.currentexercise})
      : super(key: key);

  @override
  State<exerciseDetail> createState() => _exerciseDetailState();
}

class _exerciseDetailState extends State<exerciseDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Description"),
      ),
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
                        child: Text(widget.currentexercise.exerciseName,
                            style: TextStyle(fontSize: 30))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.asset(
                      "assets/images/${widget.currentexercise.gifPath}",
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
                    child: Text(widget.currentexercise.description)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
