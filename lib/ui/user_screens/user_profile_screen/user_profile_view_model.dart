import 'package:flutter/cupertino.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';

class UserProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  void logout({@required BuildContext dialogContext}) async {
    setBusy(true);

    await _authenticationService.logout();

    setBusy(false);

    Navigator.pop(dialogContext);

    _navigationService.navigateReplacementTo(RouteNames.LoginPageRoute);
  }
}
