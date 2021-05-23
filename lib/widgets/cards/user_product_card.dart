import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/models/product_model.dart';
import 'package:sdg_hack/utils/like_count.dart';
import 'package:sdg_hack/widgets/cached_network_image.dart';

class UserProductCard extends StatelessWidget {
  final ProductModel productModel;
  final String merchantId;
  final String merchantName;

  const UserProductCard({
    Key key,
    @required this.productModel,
    @required this.merchantId,
    @required this.merchantName,
  }) : super(key: key);

  void showReward(context, ProductModel rewardModel) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => UserShowRewardPage(
    //       reward: rewardModel,
    //       merchantId: merchantId,
    //       merchantName: merchantName,
    //     ),
    //   ),
    // );
  }

  Widget buildRewardRequirementsRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: constraints.maxWidth * 0.5,
                child: Row(
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        getLikeCount(productModel.likes).toString(),
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 0.27,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.5,
                child: FittedBox(
                  child: Text(
                    "\$ ${productModel.price}",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 0.27,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildRewardNameRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: FittedBox(
        child: Text(
          productModel.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.27,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildRewardImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0.0, 0.0),
              blurRadius: 6.0),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        child: AspectRatio(
          aspectRatio: 1.00,
          child: productModel.photoUrl == ''
              ? Container()
              : cachedNetworkImage(productModel.photoUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => showReward(context, productModel),
      child: SizedBox(
        height: 280,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFB),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                // border: new Border.all(
                //     color: DesignCourseAppTheme.notWhite),
              ),
              child: Column(
                children: <Widget>[
                  buildRewardNameRow(),
                  buildRewardRequirementsRow(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
              child: buildRewardImage(),
            ),
          ],
        ),
      ),
    );
  }
}
