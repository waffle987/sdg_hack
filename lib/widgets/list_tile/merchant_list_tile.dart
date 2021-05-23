import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/user_screens/user_show_merchant_profile_screen/user_show_merchant_profile_screen.dart';

class MerchantListTile extends StatelessWidget {
  final FirestoreUser merchantModel;

  MerchantListTile({@required this.merchantModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserShowMerchantProfilePage(merchantModel: merchantModel),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: merchantModel.photoUrl == ''
                    ? Icon(
                        FontAwesomeIcons.solidUser,
                        color: kLightIconColour,
                      )
                    : Container(),
                backgroundImage: merchantModel.photoUrl == ''
                    ? null
                    : CachedNetworkImageProvider(merchantModel.photoUrl),
              ),
              title: Text(
                merchantModel.username,
                style: TextStyle(
                  color: kDarkTextColour,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(FontAwesomeIcons.chevronRight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              height: 5.0,
              color: kDarkIconColour,
            ),
          ),
        ],
      ),
    );
  }
}
