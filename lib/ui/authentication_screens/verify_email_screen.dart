import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/login_screen/login_screen.dart';
import 'package:sdg_hack/widgets/buttons/elongated_button.dart';

class VerifyEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    MediaQueryData _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeData.scaffoldBackgroundColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: _themeData.primaryColor,
        ),
      ),
      body: ListView(
        children: <Widget>[
          verticalSpaceLarge,
          Icon(
            FontAwesomeIcons.solidPaperPlane,
            size: 100.0,
            color: _themeData.primaryColor,
          ),
          verticalSpaceSmall,
          Text(
            'Please verify your email!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Login again once you have verified your email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          verticalSpaceLarge,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: _mediaQuery.size.width * 0.2),
            child: ElongatedButton(
              text: 'Back',
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
              buttonColour: _themeData.primaryColor,
              textColour: kLightTextColour,
            ),
          ),
        ],
      ),
    );
  }
}
