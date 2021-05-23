import 'package:flutter/cupertino.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/notification_model.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';
import 'package:sdg_hack/services/notification_service.dart';

class UserProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NotificationService _notificationService =
      locator<NotificationService>();

  List<NotificationModel> _notifications;
  List<NotificationModel> get notifications => _notifications;

  void logout({@required BuildContext dialogContext}) async {
    setBusy(true);

    await _authenticationService.logout();

    setBusy(false);

    Navigator.pop(dialogContext);

    _navigationService.navigateReplacementTo(RouteNames.LoginPageRoute);
  }

  void listenToNotifications({@required String currentUserId}) {
    setBusy(true);

    _notificationService
        .listenToNotifications(userId: currentUserId)
        .listen((notificationData) {
      List<NotificationModel> updatedNotifications = notificationData;
      if (updatedNotifications != null) {
        _notifications = updatedNotifications;
        notifyListeners();
      }
    });
    setBusy(false);
  }
}
