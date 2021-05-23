import 'package:flutter/material.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/widgets/logic_tree_ui/question_ui_with_2_answers.dart';

class IssuesWithDietPage extends StatelessWidget {
  const IssuesWithDietPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionWith2AnswersUI(
      question: 'What issues are you facing with your diet?',
      option1Text: 'Difficulty committing',
      option2Text: 'Not losing weight',
      routeName1: RouteNames.DifficultyCommittingPageRoute,
      routeName2: RouteNames.NotLosingWeightPageRoute,
    );
  }
}
