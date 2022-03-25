import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  final String text;
  final dynamic onPress;
  final double fontSize;

  const ReuseableButton(
      {required this.text, required this.onPress, this.fontSize = 25});

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
          onPressed: onPress,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: fontSize,
                )
              ],
            ),
          ),
        ));

  }
}
