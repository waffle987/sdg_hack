import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    bool hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      bool isVerified = await _authenticationService.isEmailVerified();

      if (!isVerified) {
        _navigationService
            .navigateReplacementTo(RouteNames.VerifyEmailPageRoute);
      } else {
        bool isMerchant = _authenticationService.isMerchant();

        if (isMerchant) {
          _navigationService
              .navigateReplacementTo(RouteNames.MerchantAuthPageRoute);
        } else {
          _navigationService
              .navigateReplacementTo(RouteNames.UserAuthPageRoute);
        }
      }
    } else {
      _navigationService.navigateReplacementTo(RouteNames.LoginPageRoute);
    }
  }
}
