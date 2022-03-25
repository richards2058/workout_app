import 'package:flutter/material.dart';

class reuseableRepsButton extends StatelessWidget {
  final String text;
  final String reps;

  final double fontSize;

  const reuseableRepsButton(
      {required this.text, this.fontSize = 25, required this.reps});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromRGBO(0, 100, 200, 1),
                Colors.lightBlueAccent,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
          ),
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Expanded(
                  // flex: 10,
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                // Spacer(),
                Text(
                  " ${reps}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
