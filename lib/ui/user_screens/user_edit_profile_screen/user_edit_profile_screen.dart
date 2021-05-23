import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/user_screens/user_edit_profile_screen/user_edit_profile_view_model.dart';
import 'package:sdg_hack/widgets/input_fields/custom_text_form_field.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';
import 'package:status_alert/status_alert.dart';

class UserEditProfilePage extends StatelessWidget {
  const UserEditProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final TextEditingController _usernameTextController =
        TextEditingController();
    final authBox = Boxes.getCurrentUserBox();
    final FirestoreUser currentUser = authBox.get(0);

    /// Build update profile information button
    Widget buildDoneButton({@required UserEditProfileViewModel model}) {
      return Padding(
        padding: EdgeInsets.only(right: _mediaQuery.size.width * 0.02),
        child: GestureDetector(
          onTap: () async {
            if (_usernameTextController.text.isNotEmpty) {
              final updateOutcome = await model.updateUsername(
                username: _usernameTextController.text,
                currentUser: currentUser,
              );

              if (!updateOutcome) {
                StatusAlert.show(
                  context,
                  duration: Duration(seconds: 2),
                  title: 'Taken',
                  subtitle: 'This username is unavailable!',
                  configuration:
                      IconConfiguration(icon: FontAwesomeIcons.timesCircle),
                );

                model.navigationPop();
              } else {
                StatusAlert.show(
                  context,
                  duration: Duration(seconds: 2),
                  title: 'Updated',
                  subtitle: 'Your profile has been updated!',
                  configuration:
                      IconConfiguration(icon: FontAwesomeIcons.check),
                );

                model.updateUsername(
                  username: _usernameTextController.text,
                  currentUser: currentUser,
                );

                currentUser.username = _usernameTextController.text;

                authBox.putAt(0, currentUser);

                model.navigationPop();
              }
            } else {
              StatusAlert.show(
                context,
                duration: Duration(seconds: 2),
                title: 'Blank fields!',
                subtitle: 'Please fill in all fields!',
                configuration: IconConfiguration(icon: FontAwesomeIcons.check),
              );

              model.navigationPop();
            }
          },
          child: CircleAvatar(
            backgroundColor: _themeData.primaryColor,
            child: Icon(
              FontAwesomeIcons.check,
              color: _themeData.scaffoldBackgroundColor,
            ),
          ),
        ),
      );
    }

    return ViewModelBuilder<UserEditProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => UserEditProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: kDarkTextColour,
              ),
            ),
            backgroundColor: _themeData.scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.chevronCircleLeft,
                size: 30.0,
              ),
              onPressed: () => model.navigationPop(),
            ),
            iconTheme: IconThemeData(color: kDarkIconColour),
            elevation: 0.0,
            actions: [
              buildDoneButton(model: model),
            ],
          ),
          body: model.busy
              ? circularProgressIndicator(context: context)
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      verticalSpaceMedium,
                      CustomTextFormField(
                        header: 'Username',
                        hintText: currentUser.username != null
                            ? currentUser.username
                            : '',
                        textEditingController: _usernameTextController,
                        textInputType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
