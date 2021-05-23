import 'package:flutter/material.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/widgets/buttons/elongated_button.dart';

class ResultPage extends StatelessWidget {
  final String outcomeHeaderText;
  final String outcomeSubtitleText;
  final IconData iconData;
  final Function backFunction;
  final Color resultPageColour;
  final bool haveBackButton;

  ResultPage({
    @required this.iconData,
    @required this.outcomeHeaderText,
    @required this.outcomeSubtitleText,
    this.backFunction,
    @required this.resultPageColour,
    @required this.haveBackButton,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: themeData.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: _mediaQueryData.size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(
                  iconData,
                  color: resultPageColour,
                  size: 100.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  outcomeHeaderText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  outcomeSubtitleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Column(
              children: [
                ElongatedButton(
                  text: 'Done',
                  onPressed: () => Navigator.pop(context),
                  buttonColour: resultPageColour,
                  textColour: kLightTextColour,
                ),
                haveBackButton ? verticalSpaceLarge : Container(),
                haveBackButton
                    ? GestureDetector(
                        onTap: backFunction,
                        child: Text(
                          'Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
