import 'package:hive/hive.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class UserLandingPageViewModel extends IndexTrackingViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void addUserProfileToState() async {
    final authBox = Hive.box('auth');

    authBox.add(_authenticationService.currentUser);

    print(authBox.get(0));
  }
}
