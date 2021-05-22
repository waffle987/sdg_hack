import 'package:flutter/material.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/ui/authentication_screens/reset_password_screen.dart';
import 'package:sdg_hack/ui/authentication_screens/verify_email_screen.dart';
import 'package:sdg_hack/ui/create_account_screen/create_account_screen.dart';
import 'package:sdg_hack/ui/login_screen/login_screen.dart';
import 'package:sdg_hack/ui/startup_screen/startup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    /// Authentication pages
    case RouteNames.LoginPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginPage(),
      );

    case RouteNames.SignUpPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpPage(),
      );

    case RouteNames.StartUpPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUpPage(),
      );

    case RouteNames.VerifyEmailPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VerifyEmailPage(),
      );

    case RouteNames.ResetPasswordPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResetPasswordPage(),
      );

    /// User auth pages

    case RouteNames.UserAuthPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Scaffold(),
      );

    ///  Merchant auth pages

    case RouteNames.MerchantAuthPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Scaffold(),
      );

    // case RouteNames.MerchantAddContentPageRoute:
    //   return _getPageRoute(
    //     routeName: settings.name,
    //     viewToShow: AddContentPage(),
    //   );
    //
    // case RouteNames.MerchantEditProfilePageRoute:
    //   return _getPageRoute(
    //     routeName: settings.name,
    //     viewToShow: MerchantEditProfilePage(),
    //   );
    //
    // case RouteNames.MerchantEditProfilePicturePageRoute:
    //   return _getPageRoute(
    //     routeName: settings.name,
    //     viewToShow: MerchantChangeProfilePicturePage(),
    //   );

    /// Default route
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
