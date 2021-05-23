import 'package:flutter/material.dart';
import 'package:sdg_hack/config/ui_helpers.dart';

Widget card({
  @required String header,
  @required String title,
  String subtitle,
  @required Color cardColour,
  @required Color textColour,
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
        verticalSpaceSmall,
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: textColour,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        subtitle != null
            ? Column(
                children: [
                  verticalSpaceSmall,
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: textColour,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Container(),
      ],
    ),
  );
}
