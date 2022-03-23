import 'package:flutter/material.dart';

class reuseableCenterButton extends StatelessWidget {
  final String text;
  final dynamic onPress;
  final double fontSize;

  const reuseableCenterButton(
      {required this.text, required this.onPress, this.fontSize = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onPressed: onPress,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              )),
        ));
    ;
  }
}
