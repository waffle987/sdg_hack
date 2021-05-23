import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/see_food_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_find_merchants_screen/user_find_merchant_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_home_screen/user_home_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_profile_screen/user_profile_screen.dart';
import 'package:stacked/stacked.dart';

import 'user_landing_view_model.dart';

class UserLandingPage extends StatelessWidget {
  const UserLandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    return ViewModelBuilder<UserLandingPageViewModel>.reactive(
      disposeViewModel: false,
      onModelReady: (model) => model.addUserProfileToState(),
      viewModelBuilder: () => UserLandingPageViewModel(),
      builder: (_, model, __) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.camera,
            color: _themeData.accentColor,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SeeFoodPage(),
            ),
          ),
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            FontAwesomeIcons.home,
            FontAwesomeIcons.search,
            FontAwesomeIcons.users,
            FontAwesomeIcons.solidUserCircle,
          ],
          backgroundColor: _themeData.primaryColor,
          activeColor: _themeData.accentColor,
          splashColor: _themeData.accentColor,
          inactiveColor: Colors.white.withOpacity(0.7),
          iconSize: 30.0,
          gapLocation: GapLocation.center,
          activeIndex: model.currentIndex,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: model.setIndex,
          //other params
        ),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return UserHomePage();
      case 1:
        return UserFindMerchantPage();
      case 2:
        return Scaffold();
      case 3:
        return UserProfilePage();
      default:
        return Scaffold();
    }
  }
}
