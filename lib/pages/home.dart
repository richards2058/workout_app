import 'package:flutter/material.dart';
import 'package:workout_app/pages/Calendar.dart';
import 'package:workout_app/pages/Dummy.dart';
import 'package:workout_app/components/iconButton.dart';

class Home extends StatelessWidget {
  TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Move It")),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(0, 100, 200, 1),
                        Colors.lightBlueAccent,
                      ],
                    )),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("Hello",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text("Saturday, 5 Febuary 2022",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                )),
            reuseableButton(
              text: "Today's Workout",
              fontSize: 30,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => dummy()));
              },
              frontIcon: Icon(
                Icons.radio_button_unchecked_outlined,
                size: 40,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
