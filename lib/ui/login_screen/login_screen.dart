import 'package:flutter/material.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/login_screen/login_view_model.dart';
import 'package:sdg_hack/widgets/buttons/busy_button.dart';
import 'package:sdg_hack/widgets/input_fields/input_field.dart';
import 'package:sdg_hack/widgets/text_link.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: _mediaQuery.size.height * 0.15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Text(
                      'SeeFood',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                  InputField(
                    placeholder: 'Email',
                    controller: emailController,
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Password',
                    password: true,
                    controller: passwordController,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: 'Login',
                        busy: model.busy,
                        onPressed: () {
                          model.login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                      )
                    ],
                  ),
                  verticalSpaceMedium,
                  TextLink(
                    'Create an Account',
                    onPressed: () {
                      model.navigateToSignUp();
                    },
                  ),
                  verticalSpaceSmall,
                  Text('or'),
                  verticalSpaceSmall,
                  TextLink(
                    'Forgot password?',
                    onPressed: () {
                      model.navigateToResetPassword();
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
