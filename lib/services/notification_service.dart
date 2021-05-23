import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdg_hack/models/notification_model.dart';

class NotificationService {
  final CollectionReference _notificationsCollectionReference =
      FirebaseFirestore.instance.collection('notifications');

  final StreamController<List<NotificationModel>> _notificationController =
      StreamController<List<NotificationModel>>.broadcast();

  /// Listen to stream of notifications
  Stream<List<NotificationModel>> listenToNotifications(
      {@required String userId}) {
    _notificationsCollectionReference
        .doc(userId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((notificationsSnapshot) {
      if (notificationsSnapshot.docs.isNotEmpty) {
        List<NotificationModel> _notifications =
            notificationsSnapshot.docs.length == 0
                ? []
                : notificationsSnapshot.docs
                    .map((doc) => NotificationModel.fromDocument(doc))
                    .toList();
        _notificationController.add(_notifications);
      }
    });

    return _notificationController.stream;
  }

  /// Send Merchant use voucher notification (Type: "use voucher")

  void sendMerchantUseVoucherNotification({
    @required String merchantId,
    @required String notificationId,
    @required String title,
  }) {
    _notificationsCollectionReference
        .doc(merchantId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'use voucher',
      'message': 'A customer has used a $title Voucher!',
      'timestamp': DateTime.now(),
    });
  }

  /// Send User use voucher notification (Type: "use voucher")

  void sendUserUseVoucherNotification({
    @required String userId,
    @required String notificationId,
    @required String title,
    @required String merchantName,
  }) {
    _notificationsCollectionReference
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'use voucher',
      'message': 'You have used a $title Voucher at $merchantName!',
      'timestamp': DateTime.now(),
    });
  }

  /// Send Merchant redeem voucher notification (Type: "redeem voucher")

  void sendMerchantRedeemVoucherNotification({
    @required String merchantId,
    @required String notificationId,
    @required String title,
  }) {
    _notificationsCollectionReference
        .doc(merchantId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'redeem voucher',
      'message': 'A customer has redeemed a $title Voucher!',
      'timestamp': DateTime.now(),
    });
  }

  /// Send User redeem voucher notification (Type: "redeem voucher")

  void sendUserRedeemVoucherNotification({
    @required String userId,
    @required String notificationId,
    @required String title,
    @required String merchantName,
  }) {
    _notificationsCollectionReference
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'redeem voucher',
      'message': 'You have redeemed a $title Voucher at $merchantName!',
      'timestamp': DateTime.now(),
    });
  }

  /// Send Merchant redeem voucher notification (Type: "complete task")

  void sendMerchantCompleteTaskNotification({
    @required String merchantId,
    @required String notificationId,
    @required String pointsAwarded,
    @required String task,
  }) {
    _notificationsCollectionReference
        .doc(merchantId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'complete task',
      'message': 'A customer has completed $task for $pointsAwarded!',
      'timestamp': DateTime.now(),
    });
  }

  /// Send User redeem voucher notification (Type: "complete task")

  void sendUserCompleteTaskNotification({
    @required String userId,
    @required String notificationId,
    @required String pointsAwarded,
    @required String task,
    @required String merchantName,
  }) {
    _notificationsCollectionReference
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .set({
      'type': 'complete task',
      'message':
          'You have completed $task with $merchantName for $pointsAwarded!',
      'timestamp': DateTime.now(),
    });
  }
}
