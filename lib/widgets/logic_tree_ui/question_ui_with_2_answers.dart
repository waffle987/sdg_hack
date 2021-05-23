import 'package:flutter/material.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/logic_tree_view_model.dart';
import 'package:sdg_hack/widgets/buttons/elongated_button.dart';
import 'package:stacked/stacked.dart';

class QuestionWith2AnswersUI extends StatelessWidget {
  final String question;
  final String option1Text;
  final String option2Text;
  final String routeName1;
  final String routeName2;
  final String routeNameBack;

  QuestionWith2AnswersUI({
    @required this.question,
    @required this.option1Text,
    @required this.option2Text,
    @required this.routeName1,
    @required this.routeName2,
    this.routeNameBack,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);

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
              horizontal: _mediaQueryData.size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Column(
                children: [
                  ElongatedButton(
                    text: option1Text,
                    onPressed: () =>
                        model.navigationGoTo(routeName: routeName1),
                    buttonColour: _themeData.primaryColor,
                    textColour: _themeData.accentColor,
                  ),
                  verticalSpaceSmall,
                  ElongatedButton(
                    text: option2Text,
                    onPressed: () =>
                        model.navigationGoTo(routeName: routeName2),
                    buttonColour: _themeData.primaryColor,
                    textColour: _themeData.accentColor,
                  ),
                  verticalSpaceLarge,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
