import 'package:flutter/material.dart';

class SwitchFormField extends StatelessWidget {
  final bool boolean;
  final Function onChangedFunction;
  final String header;

  const SwitchFormField({
    Key key,
    @required this.header,
    @required this.boolean,
    @required this.onChangedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        header,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        ),
      ),
      trailing: Transform.scale(
        scale: 1.8,
        child: Switch(
          value: boolean,
          activeColor: Theme.of(context).primaryColor,
          onChanged: onChangedFunction,
        ),
      ),
    );
  }
}
