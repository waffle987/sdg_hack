import 'package:flutter/material.dart';

Container circularProgressIndicator({@required BuildContext context}) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}

linearProgressIndicator({@required BuildContext buildContext}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(buildContext).primaryColor),
    ),
  );
}
