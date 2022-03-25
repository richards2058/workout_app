import 'package:flutter/material.dart';
import 'package:workout_app/db/models/exercise.dart';

class CarouselSlide extends StatelessWidget {
  final dynamic exerciseData;

  CarouselSlide({Key? key, required this.exerciseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      child: Text(exerciseData["exerciseName"], style: TextStyle(fontSize: 30))),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    "assets/images/${exerciseData["gif"]}",
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
                  child: Text(exerciseData["description"])),
            ),
          ),
        ],
      ),
    );
  }
}
