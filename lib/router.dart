import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/ui/authentication_screens/reset_password_screen.dart';
import 'package:sdg_hack/ui/authentication_screens/verify_email_screen.dart';
import 'package:sdg_hack/ui/create_account_screen/create_account_screen.dart';
import 'package:sdg_hack/ui/login_screen/login_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_edit_profile_screen/merchant_change_profile_picture_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_edit_profile_screen/merchant_edit_profile_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_landing_screen/merchant_landing_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_upload_product_screen/merchant_upload_product_screen.dart';
import 'package:sdg_hack/ui/startup_screen/startup_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_landing_screen/user_landing_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/difficulty_committing_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/feeling_hungry_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/issues_with_diet_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/not_losing_weight_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/result_screen.dart';

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
        viewToShow: UserLandingPage(),
      );

    ///  Merchant auth pages

    case RouteNames.MerchantAuthPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MerchantLandingPage(),
      );

    case RouteNames.MerchantAddContentPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MerchantUploadProductPage(),
      );

    case RouteNames.MerchantEditProfilePageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MerchantEditProfilePage(),
      );

    case RouteNames.MerchantEditProfilePicturePageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MerchantChangeProfilePicturePage(),
      );

    /// Logic tree routes

    case RouteNames.DietIssuesPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: IssuesWithDietPage(),
      );

    case RouteNames.DifficultyCommittingPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DifficultyCommittingPage(),
      );

    case RouteNames.FeelingHungryPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FeelingHungryPage(),
      );

    case RouteNames.NotLosingWeightPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: NotLosingWeightPage(),
      );

    case RouteNames.UnmotivatedResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.handshake,
          outcomeHeaderText: 'Work with friends!',
          outcomeSubtitleText:
              'Being unmotivated is common. What may help is knowing '
              'you are not alone in your struggle. Use our social features to get the boost you need!',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.LittleWaterResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.tint,
          outcomeHeaderText: 'Drink more water!',
          outcomeSubtitleText:
              'You could be mistaking your thirst for hunger. It is recommended '
              'that you drink 3.7litres of fluids a day for men and 2.7litres of fluids a day for women.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.EnoughSleepResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.bed,
          outcomeHeaderText: 'Sleep!',
          outcomeSubtitleText:
              'Sleep regulates your hunger hormones and sleep deficiency makes'
              ' you feel hungrier. It is recommended you get 7-8 hours of sleep a day.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.CaloricDenseFoodResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.utensils,
          outcomeHeaderText: 'Try something different!',
          outcomeSubtitleText:
              'By eating caloric-dense food, you will be less full. Try switching '
              'to less caloric-dense foods to be more fill. (E.g. Switching from full cream milk to low fat milk)',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.StressedResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.couch,
          outcomeHeaderText: 'Relax!',
          outcomeSubtitleText:
              'You could be comforting your emotions with food. Try taking up '
              'healthy alternatives to reduce stress like yoga or getting professional medical help.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.DrinkCaloriesResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.infoCircle,
          outcomeHeaderText: 'Take note!',
          outcomeSubtitleText:
              'Drinks such as coffee and alcohol often contain lots of calories'
              ' as well but are not as filling as food. Try switching '
              'out your drinks to lower calorie alternatives such as diet coke or water.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.EatingOutResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.hamburger,
          outcomeHeaderText: 'Take note!',
          outcomeSubtitleText:
              'The calories in food served in restaurants may not be accurate and may be higher in calories',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.LittleExerciseResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.running,
          outcomeHeaderText: 'Take note!',
          outcomeSubtitleText:
              'By exercising very little, you may not be burning enough '
              'calories to be in a deficit to lose weight. Try exercising more or reducing your caloric intake.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.LittleExerciseResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.running,
          outcomeHeaderText: 'Take note!',
          outcomeSubtitleText:
              'You might be making the common mistake of overestimating how '
              'much calories you burn from exercise. Try lowering your'
              ' caloric intake if you are still unable to lose weight.',
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

    case RouteNames.LongDietResultPageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResultPage(
          iconData: FontAwesomeIcons.solidClock,
          outcomeHeaderText: 'Take note!',
          outcomeSubtitleText:
              "Your body's metabolic rate might have slowed down after losing "
              "weight. Calculate your metabolic rate using your new "
              "weight or simply lower your caloric intake.",
          resultPageColour: Colors.blue,
          haveBackButton: false,
        ),
      );

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
