import 'package:flutter/material.dart';

class ElongatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color buttonColour;
  final Color textColour;

  ElongatedButton({
    @required this.text,
    @required this.onPressed,
    @required this.buttonColour,
    @required this.textColour,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      color: buttonColour,
      borderRadius: BorderRadius.circular(15.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: textColour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
