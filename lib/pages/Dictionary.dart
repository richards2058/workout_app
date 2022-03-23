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
  late List data;
  List _workout = [];
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/exercise.json');
    final data = await json.decode(response);
    setState(() {
      _workout = data["muscle_group"];
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

                  return ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      String muscleG = _workout[index]['name'];
                      // print(muscleG);
                      return reuseableButton(
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
                    itemCount: _workout.length,
                  );
                }),
          ),
        ));
  }
}
