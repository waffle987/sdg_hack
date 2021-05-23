import 'package:flutter/cupertino.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';

class UserEditProfileViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<bool> updateUsername({
    @required String username,
    @required FirestoreUser currentUser,
  }) {
    return _firestoreService.userUpdateUsername(
      user: currentUser,
      username: username,
    );
  }

  void navigationPop() {
    _navigationService.pop();
  }
}
