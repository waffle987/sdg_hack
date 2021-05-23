import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/ui/empty_splash_screen/empty_splash_screen.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_profile_screen/merchant_profile_view_model.dart';
import 'package:sdg_hack/ui/user_screens/user_cart_screen/user_cart_screen.dart';
import 'package:sdg_hack/widgets/cards/user_product_card.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class UserShowMerchantProfilePage extends StatelessWidget {
  final FirestoreUser merchantModel;

  UserShowMerchantProfilePage({@required this.merchantModel});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _themeData = Theme.of(context);

    /// Build the Provider profile header
    Widget buildProfileHeader({@required MerchantProfileViewModel model}) {
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
                    merchantModel.username != null
                        ? merchantModel.username
                        : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    merchantModel.bio != null ? merchantModel.bio : '',
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
                  child: merchantModel.photoUrl == ''
                      ? Icon(
                          FontAwesomeIcons.solidUser,
                          size: 60.0,
                          color: Theme.of(context).accentColor,
                        )
                      : Container(),
                  radius: 66.0,
                  backgroundImage: merchantModel.photoUrl == ''
                      ? null
                      : CachedNetworkImageProvider(merchantModel.photoUrl),
                ),
              ],
            ),
          ],
        ),
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
                      return UserProductCard(
                        productModel: model.products[index],
                        merchantName: merchantModel.username,
                        merchantId: merchantModel.id,
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
          model.listenToProducts(merchantId: merchantModel.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: _themeData.scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserCartPage(),
            ),
          ),
          child: Icon(
            FontAwesomeIcons.cartPlus,
            color: Colors.white,
          ),
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
