import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';
import 'package:workout_app/pages/exerciseDetail.dart';

class exercises extends StatefulWidget {
  final String muscleG;

  //construtor
  const exercises({Key? key, required this.muscleG}) : super(key: key);

  @override
  State<exercises> createState() => _exercisesState();
}

class _exercisesState extends State<exercises> {
  late List data;
  List _exercises = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/exercise.json');
    final data = await json.decode(response);
    setState(() {
      _exercises = data["exercise"]
          .where((element) => element["category"] == widget.muscleG)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("MoveIt"),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: FutureBuilder(
                future: readJson(),
                builder: (context, snapshot) {
                  // Decode the JSON
                  // var workout = json.decode(snapshot.data.toString());
                  // _workout = data["things"].where((element)=>element["partName"]=="Back").toList();
                  // print(_workout);
                  print(_exercises);
                  print(widget.muscleG);

                  return ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return reuseableButton(
                        text: _exercises[index]['exerciseName'],
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new exerciseDetail(
                                          exerciseName: _exercises[index]
                                              ['exerciseName'])));
                        },
                      );
                    },
                    itemCount: _exercises.length,
                  );
                }),
          ),
        ));
  }
}
