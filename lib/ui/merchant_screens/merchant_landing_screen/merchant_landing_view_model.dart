import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class MerchantLandingPageViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void addUserProfileToState() async {
    final authBox = Boxes.getCurrentUserBox();

    authBox.add(_authenticationService.currentUser);

    print(authBox.get(0));
  }

  void navigateToAddContentPage() {
    _navigationService.navigateTo(RouteNames.MerchantAddContentPageRoute);
  }
}
