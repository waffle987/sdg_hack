import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/empty_splash_screen/empty_splash_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_edit_profile_screen/user_edit_profile_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_profile_screen/user_profile_view_model.dart';
import 'package:sdg_hack/widgets/list_tile/notification_list_tile.dart';
import 'package:sdg_hack/widgets/pop_up_dialogs/pop_up_dialog.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _themeData = Theme.of(context);
    final authBox = Boxes.getCurrentUserBox();
    final FirestoreUser currentUser = authBox.get(0);

    /// Build the notifications feed
    Widget buildUserNotifications({@required UserProfileViewModel model}) {
      return model.notifications != null
          ? ListView.builder(
              itemCount: model.notifications.length,
              padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
              itemBuilder: (context, index) => Column(
                children: [
                  const SizedBox(height: 10.0),
                  NotificationListTile(
                      notificationModel: model.notifications[index]),
                  const SizedBox(height: 5.0),
                  const Divider(),
                ],
              ),
            )
          : EmptySplashPage(
              iconData: FontAwesomeIcons.solidBell,
              title: 'All caught up!',
              subtitle: 'You have no notifications in your Activity Feed yet!'
                  ' Please check back later!',
            );
    }

    return ViewModelBuilder<UserProfileViewModel>.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      onModelReady: (model) =>
          model.listenToNotifications(currentUserId: currentUser.id),
      builder: (_, model, __) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _themeData.scaffoldBackgroundColor,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Text(
                  currentUser.username,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30.0,
                    color: _themeData.primaryColor,
                  ),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserEditProfilePage(),
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: _themeData.primaryColor,
                  child: Icon(
                    FontAwesomeIcons.solidEdit,
                    color: _themeData.accentColor,
                  ),
                ),
              ),
              SizedBox(width: _mediaQuery.size.width * 0.02),
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return popUpDialog(
                      dialogContext: dialogContext,
                      function: () =>
                          model.logout(dialogContext: dialogContext),
                      description: 'Log out?',
                      noColourButtonText: 'No',
                      colourButtonText: 'Yes',
                      buttonColour: Colors.red,
                      icon: const Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      circularImageColour: Colors.red,
                    );
                  },
                ),
              ),
              SizedBox(width: _mediaQuery.size.width * 0.03),
            ],
          ),
          body: model.busy
              ? circularProgressIndicator(context: context)
              : buildUserNotifications(model: model),
        ),
      ),
    );
  }
}
