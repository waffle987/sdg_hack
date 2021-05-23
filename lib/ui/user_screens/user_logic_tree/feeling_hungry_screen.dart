import 'package:flutter/material.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/widgets/logic_tree_ui/question_ui_with_4_scenarios.dart';

class FeelingHungryPage extends StatelessWidget {
  const FeelingHungryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionWith4ScenariosUI(
      question: 'Have you been...',
      scenario1Text: 'Drinking very little water',
      scenario2Text: 'Eating caloric-dense food ',
      scenario3Text: 'Getting enough sleep',
      scenario4Text: 'Feeling stressed',
      routeName1: RouteNames.LittleWaterResultPageRoute,
      routeName2: RouteNames.CaloricDenseFoodResultPageRoute,
      routeName3: RouteNames.EnoughSleepResultPageRoute,
      routeName4: RouteNames.StressedResultPageRoute,
      routeNameBack: RouteNames.DifficultyCommittingPageRoute,
    );
  }
}
