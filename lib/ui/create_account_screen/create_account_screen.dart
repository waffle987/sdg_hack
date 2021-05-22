import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/create_account_screen/create_account_view_model.dart';
import 'package:sdg_hack/widgets/buttons/busy_button.dart';
import 'package:sdg_hack/widgets/expansion_list.dart';
import 'package:sdg_hack/widgets/input_fields/input_field.dart';
import 'package:sdg_hack/widgets/text_link.dart';
import 'package:stacked/stacked.dart';
import 'package:status_alert/status_alert.dart';

class SignUpPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _themeData = Theme.of(context);

    Widget termsAndConditionsSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceLarge,
          Text(
            "By joining Slick through Email sign up, you agree to",
            textAlign: TextAlign.center,
          ),
          verticalSpaceSmall,
          TextLink("Slick's General Terms of Use", onPressed: () {}),
          verticalSpaceSmall,
          Text('and'),
          verticalSpaceSmall,
          TextLink("Privacy Policy", onPressed: () {}),
        ],
      );
    }

    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: _themeData.scaffoldBackgroundColor,
          iconTheme: IconThemeData(
            color: _themeData.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: _mediaQuery.size.height * 0.15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 38.0),
                ),
                verticalSpaceLarge,
                InputField(
                  placeholder: 'Email',
                  controller: emailController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                  additionalNote:
                      'Password has to be a minimum of 6 characters.',
                ),
                verticalSpaceSmall,
                ExpansionList<String>(
                  items: ['Merchant', 'User'],
                  title: model.selectedRole,
                  onItemSelected: model.setSelectedRole,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BusyButton(
                      title: 'Sign Up',
                      busy: model.busy,
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          model.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } else {
                          StatusAlert.show(
                            context,
                            duration: Duration(seconds: 2),
                            title: 'Blanks!',
                            subtitle: 'Please fill in all the fields!',
                            configuration: IconConfiguration(
                                icon: FontAwesomeIcons.timesCircle),
                          );
                        }
                      },
                    ),
                  ],
                ),
                termsAndConditionsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
