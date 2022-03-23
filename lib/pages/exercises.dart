import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';
import 'package:workout_app/pages/exerciseDetail.dart';
import 'package:workout_app/db/models/exercise.dart';

class exercises extends StatefulWidget {
  final String muscleG;

  //construtor
  const exercises({Key? key, required this.muscleG}) : super(key: key);

  @override
  State<exercises> createState() => _exercisesState();
}

class _exercisesState extends State<exercises> {
  List _exercises = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/exercise.json');
    final data = await json.decode(response);
    setState(() {
      _exercises = data["exercise"]
          .where((element) => element["category"] == widget.muscleG)
          .toList();
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
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: ListView.builder(
              // Build the ListView
              itemCount: _exercises.length,
              itemBuilder: (BuildContext context, int index) {
                return reuseableButton(
                  text: _exercises[index]['exerciseName'],
                  onPress: () {
                    exercise thisExercise = exercise.fromJson(_exercises[index]);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new exerciseDetail(currentexercise: thisExercise,)
                        )
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
