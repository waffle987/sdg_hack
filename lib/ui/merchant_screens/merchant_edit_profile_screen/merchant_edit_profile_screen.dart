import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_edit_profile_screen/merchant_edit_profile_view_model.dart';
import 'package:sdg_hack/widgets/buttons/circle_button.dart';
import 'package:sdg_hack/widgets/input_fields/custom_text_form_field.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';
import 'package:status_alert/status_alert.dart';

class MerchantEditProfilePage extends StatelessWidget {
  final TextEditingController _bioTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final authBox = Boxes.getCurrentUserBox();
    final FirestoreUser currentUser = authBox.get(0);

    /// Build update profile information button
    Widget buildDoneButton({@required MerchantEditProfileViewModel model}) {
      return Padding(
        padding: EdgeInsets.only(right: _mediaQuery.size.width * 0.02),
        child: CircleButton(
          function: () async {
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
                if (_bioTextController.text.isNotEmpty) {
                  model.updateBio(
                    bio: _bioTextController.text,
                    currentUser: currentUser,
                  );

                  currentUser.bio = _bioTextController.text;
                }

                currentUser.username = _usernameTextController.text;

                authBox.putAt(0, currentUser);

                StatusAlert.show(
                  context,
                  duration: Duration(seconds: 2),
                  title: 'Updated',
                  subtitle: 'Your profile has been updated!',
                  configuration:
                      IconConfiguration(icon: FontAwesomeIcons.check),
                );

                model.navigationPop();
              }
            } else {
              if (_bioTextController.text.isNotEmpty) {
                model.updateBio(
                  bio: _bioTextController.text,
                  currentUser: currentUser,
                );

                currentUser.bio = _bioTextController.text;

                authBox.putAt(0, currentUser);
              }

              StatusAlert.show(
                context,
                duration: Duration(seconds: 2),
                title: 'Updated',
                subtitle: 'Your profile has been updated!',
                configuration: IconConfiguration(icon: FontAwesomeIcons.check),
              );

              model.navigationPop();
            }
          },
          buttonColour: Colors.green,
          icon: FontAwesomeIcons.check,
          iconColour: Colors.white,
        ),
      );
    }

    Widget buildProfilePhoto({
      @required String photoUrl,
      @required MerchantEditProfileViewModel model,
    }) {
      return Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: CircleAvatar(
              backgroundColor: _themeData.primaryColor,
              radius: 60.0,
              child: photoUrl != ''
                  ? null
                  : Icon(
                      FontAwesomeIcons.solidUser,
                      size: 50.0,
                      color: kLightIconColour,
                    ),
              backgroundImage:
                  photoUrl == '' ? null : CachedNetworkImageProvider(photoUrl),
            ),
          ),
          Positioned(
            right: 10.0,
            bottom: 12.0,
            child: GestureDetector(
                onTap: () => model.navigateTo(
                    routeName: RouteNames.MerchantEditProfilePicturePageRoute),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  radius: 15.0,
                  child: Icon(
                    FontAwesomeIcons.camera,
                    size: 15.0,
                    color: kLightIconColour,
                  ),
                )),
          ),
        ],
      );
    }

    return ViewModelBuilder<MerchantEditProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MerchantEditProfileViewModel(),
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
                      buildProfilePhoto(
                        photoUrl: currentUser.photoUrl != null
                            ? currentUser.photoUrl
                            : '',
                        model: model,
                      ),
                      verticalSpaceMedium,
                      CustomTextFormField(
                        header: 'Username',
                        hintText: currentUser.username != null
                            ? currentUser.username
                            : '',
                        textEditingController: _usernameTextController,
                        textInputType: TextInputType.text,
                      ),
                      verticalSpaceMedium,
                      CustomTextFormField(
                        header: 'Bio',
                        hintText:
                            currentUser.bio != null ? currentUser.bio : '',
                        textEditingController: _bioTextController,
                        textInputType: TextInputType.multiline,
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
        );
      },
    );
  }
}
