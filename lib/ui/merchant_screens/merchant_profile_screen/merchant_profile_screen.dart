import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/empty_splash_screen/empty_splash_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_profile_screen/merchant_profile_view_model.dart';
import 'package:sdg_hack/widgets/buttons/circle_button.dart';
import 'package:sdg_hack/widgets/cards/merchant_product_card.dart';
import 'package:sdg_hack/widgets/pop_up_dialogs/pop_up_dialog.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class MerchantProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _themeData = Theme.of(context);
    final authBox = Boxes.getCurrentUserBox();
    final FirestoreUser currentUser = authBox.get(0);

    /// Build the Provider profile header
    Widget buildProfileHeader({@required MerchantProfileViewModel model}) {
      return ValueListenableBuilder(
        valueListenable: authBox.listenable(),
        builder: (_, box, __) {
          final FirestoreUser currentUser = box.get(0);

          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: _mediaQuery.size.height * 0.25,
                  padding: const EdgeInsets.only(
                    top: 66.0 + 16.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  margin: const EdgeInsets.only(
                    top: 66.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: _themeData.accentColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: ListView(
                    children: [
                      Text(
                        currentUser.username != null
                            ? currentUser.username
                            : '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        currentUser.bio != null ? currentUser.bio : '',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: _themeData.primaryColor,
                      child: currentUser.photoUrl == ''
                          ? Icon(
                              FontAwesomeIcons.solidUser,
                              size: 60.0,
                              color: Theme.of(context).accentColor,
                            )
                          : Container(),
                      radius: 66.0,
                      backgroundImage: currentUser.photoUrl == ''
                          ? null
                          : CachedNetworkImageProvider(currentUser.photoUrl),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    ////////////////////////////////////////////////////////////////////////////

    /// Build the Merchant rewards tab
    Widget buildMerchantProducts({@required MerchantProfileViewModel model}) {
      return Column(
        children: [
          Expanded(
            child: model.products != null
                ? GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    physics: BouncingScrollPhysics(),
                    itemCount: model.products.length,
                    itemBuilder: (context, index) {
                      return MerchantProductCard(
                        productModel: model.products[index],
                        deleteFunction: () async {
                          await model.deleteProducts(
                            documentId: model.products[index].productId,
                            merchantId: currentUser.id,
                            removeFromListFunction: () =>
                                model.products.removeAt(index),
                            fileName: model.products[index].fileName,
                          );
                        },
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 32.0,
                      childAspectRatio: 0.8,
                    ),
                  )
                : EmptySplashPage(
                    iconData: FontAwesomeIcons.gift,
                    title: 'No Products Listed',
                    subtitle: 'You have not listed any Products yet',
                  ),
          )
        ],
      );
    }

    return ViewModelBuilder<MerchantProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MerchantProfileViewModel(),
      onModelReady: (model) =>
          model.listenToProducts(merchantId: currentUser.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: _themeData.scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          actions: [
            CircleButton(
              icon: FontAwesomeIcons.solidEdit,
              function: () => model.navigateToEditProfilePage(),
              buttonColour: _themeData.primaryColor,
              iconColour: _themeData.accentColor,
            ),
            SizedBox(width: _mediaQuery.size.width * 0.02),
            CircleButton(
              icon: FontAwesomeIcons.signOutAlt,
              function: () => showDialog(
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
                  }),
              buttonColour: Colors.red,
              iconColour: Colors.white,
            ),
            SizedBox(width: _mediaQuery.size.width * 0.03),
          ],
        ),
        body: model.busy
            ? circularProgressIndicator(context: context)
            : Column(
                children: <Widget>[
                  buildProfileHeader(model: model),
                  Expanded(
                    child: buildMerchantProducts(model: model),
                  ),
                ],
              ),
      ),
    );
  }
}
