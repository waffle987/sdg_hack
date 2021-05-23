import 'package:flutter/material.dart';
import 'package:sdg_hack/config/styles.dart';

class NumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final String header;
  final bool isInt;

  NumberFormField({
    @required this.controller,
    @required this.header,
    @required this.isInt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: kDarkTextColour,
              fontWeight: FontWeight.w900,
            ),
          ),
          Center(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: isInt
                  ? TextInputType.number
                  : TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: isInt ? '0' : '0.00',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: numberTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
