import 'package:flutter/material.dart';

/// Colours
const Color kAccentColour = Color(0xff22A45D);
const Color kMediumGreyColour = Color(0xff868686);

const kLightTextColour = Colors.white;
const kDarkTextColour = Colors.black;

const kLightIconColour = Colors.white;
const kDarkIconColour = Colors.black;

const kLightCardColour = Colors.white;

/// TextStyle
const TextStyle buttonTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

TextStyle numberTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 50.0,
  color: kDarkTextColour,
);

/// Box Decorations
BoxDecoration fieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

/// Font Sizing
const double kBodyTextSize = 16.0;

/// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

/// TextField design

const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);
