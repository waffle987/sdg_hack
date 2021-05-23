import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/ui/empty_splash_screen/empty_splash_screen.dart';
import 'package:sdg_hack/ui/user_screens/user_find_merchants_screen/user_find_merchant_view_model.dart';
import 'package:sdg_hack/widgets/cards/card.dart';
import 'package:sdg_hack/widgets/list_tile/merchant_list_tile.dart';
import 'package:sdg_hack/widgets/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class UserFindMerchantPage extends StatelessWidget {
  const UserFindMerchantPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    Widget buildMerchantList({@required UserFindMerchantViewModel model}) {
      return Expanded(
        child: model.merchants != null
            ? ListView.builder(
                itemCount: model.merchants.length,
                padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                itemBuilder: (context, index) => Column(
                  children: [
                    MerchantListTile(merchantModel: model.merchants[index]),
                    Divider(),
                  ],
                ),
              )
            : EmptySplashPage(
                iconData: FontAwesomeIcons.store,
                title: 'No Merchants Listed',
                subtitle: 'Please come back soon!',
              ),
      );
    }

    return ViewModelBuilder<UserFindMerchantViewModel>.reactive(
      viewModelBuilder: () => UserFindMerchantViewModel(),
      onModelReady: (model) => model.listenToMerchants(),
      builder: (_, model, __) => Scaffold(
        body: SafeArea(
          child: model.busy
              ? circularProgressIndicator(context: context)
              : Column(
                  children: [
                    card(
                      header: 'Find Healthy Eateries',
                      title: 'Here are a list of the best eateries'
                          ' which offer health food options!',
                      cardColour: _themeData.primaryColor,
                      textColour: _themeData.accentColor,
                    ),
                    buildMerchantList(model: model),
                  ],
                ),
        ),
      ),
    );
  }
}
