import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/widgets/buttons/circle_button.dart';

class UserFindFriendsPage extends StatelessWidget {
  const UserFindFriendsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final MediaQueryData _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _themeData.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              'My Friends',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                color: _themeData.primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          CircleButton(
            icon: FontAwesomeIcons.plus,
            function: () {},
            buttonColour: _themeData.primaryColor,
            iconColour: _themeData.accentColor,
          ),
          SizedBox(width: _mediaQuery.size.width * 0.03),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.solidUser),
            ),
            title: Text('Rach'),
            subtitle: Text('Running is fun'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.solidUser),
            ),
            title: Text('Jia Jun'),
            subtitle: Text('Training for IPPT'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.solidUser),
            ),
            title: Text('Jing Jie'),
            subtitle: Text('240 KG deadlift'),
          ),
        ],
      ),
    );
  }
}
