import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:status_alert/status_alert.dart';

class ResetPasswordPage extends StatelessWidget {
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Widget _buildEmailResetBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 4.0,
                    bottom: 4.0,
                  ),
                  child: TextField(
                    controller: emailController,
                    onChanged: (String txt) {},
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                onTap: () {
                  if (emailController.text.isEmpty ||
                      !emailController.text.contains('@')) {
                    StatusAlert.show(
                      context,
                      duration: Duration(seconds: 2),
                      title: 'Unsuccessful',
                      subtitle: 'The email entered is invalid',
                      configuration:
                          IconConfiguration(icon: FontAwesomeIcons.timesCircle),
                    );
                  } else {
                    FocusScope.of(context).requestFocus(FocusNode());

                    _auth.sendPasswordResetEmail(email: emailController.text);

                    Navigator.pop(context);

                    StatusAlert.show(
                      context,
                      duration: Duration(seconds: 3),
                      title: 'Sent',
                      subtitle: 'A password reset link has been sent',
                      configuration: IconConfiguration(
                          icon: FontAwesomeIcons.solidPaperPlane),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: _themeData.primaryColor,
        ),
        title: Text(
          'Reset Password',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: kDarkTextColour,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(height: 20.0),
          _buildEmailResetBar(context),
        ],
      ),
    );
  }
}
