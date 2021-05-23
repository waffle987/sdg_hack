import 'package:flutter/material.dart';
import 'package:sdg_hack/widgets/buttons/elongated_button.dart';

// Build options cards
Widget cardWithElongatedButton({
  @required String header,
  String body,
  @required String buttonText,
  @required Color cardColour,
  @required Color buttonColour,
  @required Color buttonTextColour,
  @required Color textColour,
  @required Function function,
  @required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.only(
      top: 16.0,
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
    ),
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
    ),
    decoration: BoxDecoration(
      color: cardColour,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
            color: textColour,
          ),
        ),
        const SizedBox(height: 15.0),
        body != null
            ? Column(
                children: [
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: textColour,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15.0),
                ],
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElongatedButton(
            buttonColour: buttonColour,
            textColour: buttonTextColour,
            text: buttonText,
            onPressed: function,
          ),
        )
      ],
    ),
  );
}

Widget cardWith2TextAndElongatedButton({
  @required String header,
  @required String title,
  @required String subtitle,
  @required String buttonText,
  @required Color cardColour,
  @required Color buttonColour,
  @required Color buttonTextColour,
  @required Color textColour,
  @required TextStyle titleTextStyle,
  @required TextStyle subtitleTextStyle,
  @required Function function,
  @required BuildContext context,
}) {
  return Container(
    padding: const EdgeInsets.only(
      top: 16.0,
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
    ),
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
    ),
    decoration: BoxDecoration(
      color: cardColour,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
            color: textColour,
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          title,
          style: titleTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        Text(
          subtitle,
          style: subtitleTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElongatedButton(
            buttonColour: buttonColour,
            textColour: buttonTextColour,
            text: buttonText,
            onPressed: function,
          ),
        )
      ],
    ),
  );
}
