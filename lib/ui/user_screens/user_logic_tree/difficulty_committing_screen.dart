import 'package:flutter/material.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/widgets/logic_tree_ui/question_ui_with_2_answers.dart';

class DifficultyCommittingPage extends StatelessWidget {
  const DifficultyCommittingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionWith2AnswersUI(
      question: 'Why do you have difficulty committing to your diet?',
      option1Text: 'Feeling hungry',
      option2Text: 'Feeling unmotivated',
      routeName1: RouteNames.FeelingHungryPageRoute,
      routeName2: RouteNames.UnmotivatedResultPageRoute,
      routeNameBack: RouteNames.DietIssuesPageRoute,
    );
  }
}
