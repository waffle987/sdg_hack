import 'package:flutter/material.dart';
import 'package:sdg_hack/config/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String header;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final iconWithSizedBox;

  const CustomTextFormField({
    Key key,
    @required this.hintText,
    @required this.header,
    @required this.textEditingController,
    @required this.textInputType,
    this.iconWithSizedBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              iconWithSizedBox == null ? Container() : iconWithSizedBox,
              Text(
                header,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Container(
            child: TextFormField(
              controller: textEditingController,
              keyboardType: textInputType,
              maxLines: null,
              decoration: kTextFieldInputDecoration.copyWith(
                hintText: hintText == '' ? 'Type here...' : hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
