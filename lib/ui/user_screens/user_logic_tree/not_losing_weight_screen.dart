import 'package:flutter/material.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/widgets/logic_tree_ui/question_ui_with_5_scenarios.dart';

class NotLosingWeightPage extends StatelessWidget {
  const NotLosingWeightPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionWith5ScenariosUI(
      question: 'Have you been...',
      scenario1Text: 'Counting the calories in your drinks',
      scenario2Text: 'Eating out a lot',
      scenario3Text: 'Exercising very little',
      scenario4Text: 'Exercising a lot',
      scenario5Text: 'Dieting for a long time',
      routeName1: RouteNames.DrinkCaloriesResultPageRoute,
      routeName2: RouteNames.EatingOutResultPageRoute,
      routeName3: RouteNames.LittleExerciseResultPageRoute,
      routeName4: RouteNames.ALotOfExerciseResultPageRoute,
      routeName5: RouteNames.LongDietResultPageRoute,
      routeNameBack: RouteNames.DietIssuesPageRoute,
    );
  }
}
