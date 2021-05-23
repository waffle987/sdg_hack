import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/models/product_model.dart';
import 'package:sdg_hack/utils/like_count.dart';
import 'package:sdg_hack/widgets/cached_network_image.dart';

class MerchantShowProductPage extends StatefulWidget {
  final ProductModel product;

  MerchantShowProductPage({this.product});

  @override
  _MerchantShowProductPageState createState() =>
      _MerchantShowProductPageState();
}

class _MerchantShowProductPageState extends State<MerchantShowProductPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  var opacity1 = 0.0;
  var opacity2 = 0.0;
  var opacity3 = 0.0;

  void setData() async {
    animationController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));

    setData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);

    Widget buildLikesSection({@required BoxConstraints constraints}) {
      return Container(
        width: constraints.maxWidth * 0.475,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              getLikeCount(widget.product.likes).toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                letterSpacing: 0.27,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.red,
              size: 24.0,
            ),
          ],
        ),
      );
    }

    Widget buildRewardNameSection() {
      return FittedBox(
        child: Text(
          widget.product.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22.0,
            letterSpacing: 0.27,
            color: Colors.black,
          ),
        ),
      );
    }

    Widget buildPriceSection({@required BoxConstraints constraints}) {
      return Container(
        width: constraints.maxWidth * 0.45,
        child: FittedBox(
          child: Text(
            "\$ ${widget.product.price}",
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              letterSpacing: 0.27,
              color: _themeData.primaryColor,
            ),
          ),
        ),
      );
    }

    Widget buildRewardRequirementsAndLikesRow() {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildPriceSection(constraints: constraints),
              SizedBox(width: constraints.maxWidth * 0.05),
              buildLikesSection(constraints: constraints),
            ],
          );
        },
      );
    }

    Widget buildRewardDescription() {
      return Row(
        children: <Widget>[
          Flexible(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: opacity2,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 0.27,
                  color: Colors.black,
                ),
                maxLines: null,
              ),
            ),
          ),
        ],
      );
    }

    /// Build the UI for the back button

    Widget buildBackButton() {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Card(
          child: SizedBox(
            width: AppBar().preferredSize.height - 20,
            height: AppBar().preferredSize.height - 20,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                cachedNetworkImage(widget.product.photoUrl),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width + 10.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40.0,
                      left: 18.0,
                      right: 18.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        buildRewardNameSection(),
                        const SizedBox(height: 20.0),
                        buildRewardRequirementsAndLikesRow(),
                        const SizedBox(height: 20.0),
                        buildRewardDescription(),
                        const SizedBox(height: 80.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            buildBackButton(),
          ],
        ),
      ),
    );
  }
}
