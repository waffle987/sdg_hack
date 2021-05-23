import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/assets.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_edit_profile_screen/merchant_edit_profile_view_model.dart';
import 'package:sdg_hack/widgets/buttons/busy_button.dart';
import 'package:stacked/stacked.dart';

class MerchantChangeProfilePicturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _themeData = Theme.of(context);

    /// Build splash page for image selection
    Container buildSplashScreen(
        {@required MerchantEditProfileViewModel model}) {
      return Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SvgPicture.asset(
                Assets.uploadSplashScreen,
                height: 260.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
                child: Text(
                  'Select an option',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
                child: Material(
                  color: _themeData.primaryColor,
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: MaterialButton(
                    onPressed: () => model.selectImage(isCamera: true),
                    minWidth: 200.0,
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: kLightTextColour,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
                child: Material(
                  color: _themeData.primaryColor,
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: MaterialButton(
                    onPressed: () => model.selectImage(isCamera: false),
                    minWidth: 200.0,
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Library',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: kLightTextColour,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => model.navigationPop(),
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    /// Build profile picture image preview screen
    Scaffold buildUploadProfilePicturePreviewScreen(
        {@required MerchantEditProfileViewModel model}) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: _themeData.scaffoldBackgroundColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.chevronCircleLeft,
              color: Colors.black,
            ),
            onPressed: () => model.navigationPop(),
          ),
          title: Text(
            'Profile picture',
            style: const TextStyle(
                color: kDarkTextColour,
                fontSize: 20.0,
                fontWeight: FontWeight.w900),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: _mediaQuery.size.width * 0.02,
                top: _mediaQuery.size.width * 0.02,
                bottom: _mediaQuery.size.width * 0.02,
              ),
              child: BusyButton(
                title: 'Upload',
                busy: model.busy,
                onPressed: () => model.uploadProfilePicture(),
              ),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 400.0,
                width: _mediaQuery.size.width * 0.8,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(model.selectedImage),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ViewModelBuilder<MerchantEditProfileViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MerchantEditProfileViewModel(),
      builder: (context, model, child) => Scaffold(
        body: model.selectedImage == null
            ? buildSplashScreen(model: model)
            : buildUploadProfilePicturePreviewScreen(model: model),
      ),
    );
  }
}
