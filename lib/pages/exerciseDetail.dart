import 'package:flutter/material.dart';

class exerciseDetail extends StatefulWidget {
  final String exerciseName;

  const exerciseDetail({Key? key, required this.exerciseName})
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
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                  child: Text(widget.exerciseName,
                      style: TextStyle(fontSize: 30))),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                "assets/images/Burpees.gif",
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                      "1.A\n
                      2.B\n
                      3.C\n"
                      )),
            )
          ],
        ),
      ),
    );
  }
}
