import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/components/button.dart';

import 'exercises.dart';

void main() {
  runApp(MaterialApp(
    home: Dictionary(),
  ));
}

class Dictionary extends StatefulWidget {
  @override
  DictionaryState createState() => DictionaryState();
}

class DictionaryState extends State<Dictionary> {
  List _workout = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/exercise.json');
    final data = await json.decode(response);
    setState(() {
      _workout = data["muscle_group"];
    });
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
            child: ListView.builder(
              // Build the ListView
              itemCount: _workout.length,
              itemBuilder: (BuildContext context, int index) {
                return ReuseableButton(
                  text: _workout[index]['name'],
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => exercises(
                                muscleG: _workout[index]['name'])));
                  },
                );
              },
            ),
          ),
        ));
  }
}
