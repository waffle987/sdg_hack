import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/models/notification_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationListTile extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationListTile({
    Key key,
    @required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notificationModel.type == 'redeem voucher') {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            FontAwesomeIcons.gift,
            color: Colors.white,
          ),
        ),
        title: Text(notificationModel.message),
        trailing: Text(
          timeago.format(notificationModel.timestamp.toDate()),
        ),
      );
    } else if (notificationModel.type == 'use voucher') {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
        ),
        title: Text(notificationModel.message),
        trailing: Text(
          timeago.format(notificationModel.timestamp.toDate()),
        ),
      );
    } else if (notificationModel.type == 'complete task') {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurpleAccent,
          child: Icon(
            FontAwesomeIcons.running,
            color: Colors.white,
          ),
        ),
        title: Text(notificationModel.message),
        trailing: Text(
          timeago.format(notificationModel.timestamp.toDate()),
        ),
      );
    } else {
      return Container();
    }
  }
}
