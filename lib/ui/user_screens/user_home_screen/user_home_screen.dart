import 'package:flutter/material.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/user_screens/user_logic_tree/issues_with_diet_screen.dart';
import 'package:sdg_hack/widgets/cards/card.dart';
import 'package:sdg_hack/widgets/cards/card_with_elongated_button.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeData.scaffoldBackgroundColor,
        title: Row(
          children: [
            Text(
              'SeeFood',
              style: TextStyle(
                color: _themeData.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          card(
            header: '100',
            title: 'Calories left',
            cardColour: _themeData.primaryColor,
            textColour: _themeData.accentColor,
          ),
          verticalSpaceMedium,
          card(
            header: '12 🔥',
            title: 'Diet Streak',
            cardColour: _themeData.primaryColor,
            textColour: _themeData.accentColor,
          ),
          verticalSpaceMedium,
          cardWithElongatedButton(
            header: 'Need help sticking to your diet? Find out more here!',
            buttonText: 'Go!',
            cardColour: _themeData.primaryColor,
            buttonColour: _themeData.accentColor,
            buttonTextColour: _themeData.primaryColor,
            textColour: _themeData.accentColor,
            function: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IssuesWithDietPage(),
              ),
            ),
            context: context,
          )
        ],
      ),
    );
  }
}
