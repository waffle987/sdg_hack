import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/empty_splash_screen/empty_splash_screen.dart';
import 'package:sdg_hack/widgets/input_fields/switch_form_field.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({Key key}) : super(key: key);

  @override
  _UserCartPageState createState() => _UserCartPageState();
}

class _UserCartPageState extends State<UserCartPage> {
  bool _isTrue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SwitchFormField(
            boolean: _isTrue,
            header: 'Bring my own container!',
            onChangedFunction: (value) {
              setState(() {
                _isTrue = value;
              });
            },
          ),
          verticalSpaceLarge,
          EmptySplashPage(
            iconData: FontAwesomeIcons.cartPlus,
            title: 'No items in cart',
            subtitle: 'Select products to order and pickup!',
          ),
        ],
      ),
    );
  }
}
