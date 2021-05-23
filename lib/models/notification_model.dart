import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NotificationModel {
  final String type;
  final String message;
  final Timestamp timestamp;

  NotificationModel({
    @required this.type,
    @required this.message,
    @required this.timestamp,
  });

  factory NotificationModel.fromDocument(DocumentSnapshot doc) {
    return NotificationModel(
      type: doc['type'],
      message: doc['message'],
      timestamp: doc['timestamp'],
    );
  }
}
