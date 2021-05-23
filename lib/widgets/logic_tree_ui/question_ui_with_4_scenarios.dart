import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/logic_tree_view_model.dart';
import 'package:stacked/stacked.dart';

class QuestionWith4ScenariosUI extends StatelessWidget {
  final String question;
  final String scenario1Text;
  final String scenario2Text;
  final String scenario3Text;
  final String scenario4Text;
  final String routeName1;
  final String routeName2;
  final String routeName3;
  final String routeName4;
  final String routeNameBack;

  QuestionWith4ScenariosUI({
    @required this.question,
    @required this.scenario1Text,
    @required this.scenario2Text,
    @required this.scenario3Text,
    @required this.scenario4Text,
    @required this.routeName1,
    @required this.routeName2,
    @required this.routeName3,
    @required this.routeName4,
    this.routeNameBack,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

    Widget _scenarioAndSelectButton({
      @required String scenarioText,
      @required Function selectFunction,
    }) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  scenarioText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              horizontalSpaceMedium,
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: _themeData.primaryColor,
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    color: _themeData.accentColor,
                  ),
                ),
                onTap: selectFunction,
              ),
            ],
          ),
          verticalSpaceSmall,
          Divider(color: _themeData.primaryColor),
        ],
      );
    }

    return ViewModelBuilder<LogicTreeViewModel>.reactive(
      viewModelBuilder: () => LogicTreeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: _themeData.scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _mediaQueryData.size.width * 0.1),
          child: ListView(
            shrinkWrap: true,
            children: [
              verticalSpaceLarge,
              Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: _mediaQueryData.size.height * 0.15),
              _scenarioAndSelectButton(
                scenarioText: scenario1Text,
                selectFunction: () =>
                    model.navigationGoTo(routeName: routeName1),
              ),
              verticalSpaceLarge,
              _scenarioAndSelectButton(
                scenarioText: scenario2Text,
                selectFunction: () =>
                    model.navigationGoTo(routeName: routeName2),
              ),
              verticalSpaceLarge,
              _scenarioAndSelectButton(
                scenarioText: scenario3Text,
                selectFunction: () =>
                    model.navigationGoTo(routeName: routeName3),
              ),
              verticalSpaceLarge,
              _scenarioAndSelectButton(
                scenarioText: scenario4Text,
                selectFunction: () =>
                    model.navigationGoTo(routeName: routeName4),
              ),
              SizedBox(height: _mediaQueryData.size.height * 0.08),
              GestureDetector(
                onTap: () => routeNameBack != null
                    ? model.navigationGoTo(routeName: routeNameBack)
                    : model.navigationPop(),
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: _mediaQueryData.size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
