import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'merchant_landing_view_model.dart';

class MerchantLandingPage extends StatelessWidget {
  const MerchantLandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    return ViewModelBuilder<MerchantLandingPageViewModel>.reactive(
      disposeViewModel: false,
      onModelReady: (model) => model.addUserProfileToState(),
      viewModelBuilder: () => MerchantLandingPageViewModel(),
      builder: (context, model, child) => Scaffold(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.navigateToAddContentPage(),
          child: Icon(
            FontAwesomeIcons.plus,
            color: _themeData.accentColor,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            FontAwesomeIcons.home,
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
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'SeeFood Merchant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                )
              ],
            ),
          ),
        );
      case 1:
        return Scaffold();
      default:
        return Scaffold();
    }
  }
}
