import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/config/styles.dart';
import 'package:sdg_hack/config/ui_helpers.dart';
import 'package:sdg_hack/ui/merchant_screens/merchant_upload_product_screen/merchant_upload_product_view_model.dart';
import 'package:sdg_hack/widgets/input_fields/input_field.dart';
import 'package:stacked/stacked.dart';
import 'package:status_alert/status_alert.dart';

class MerchantUploadProductPage extends StatelessWidget {
  final TextEditingController _missionController = TextEditingController();
  final TextEditingController _missionDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData _themeData = Theme.of(context);
    final authBox = Boxes.getCurrentUserBox();
    final currentUser = authBox.get(0);

    return ViewModelBuilder<MerchantUploadProductViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => MerchantUploadProductViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: _themeData.scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: kDarkIconColour),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.setModelBusy();

            if (_missionController.text.isNotEmpty &&
                _missionDescriptionController.text.isNotEmpty &&
                model.selectedImage != null) {
              model.uploadProduct(
                name: _missionController.text,
                description: _missionDescriptionController.text,
                currentUserId: currentUser.id,
              );

              StatusAlert.show(
                context,
                duration: Duration(seconds: 2),
                title: 'Success',
                subtitle: 'You have successfully listed your Product!',
                configuration: IconConfiguration(icon: FontAwesomeIcons.check),
              );
            } else {
              model.showErrorDialog();
            }

            model.setModelNotBusy();
          },
          child: Icon(
            FontAwesomeIcons.plus,
            color: kLightIconColour,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: <Widget>[
              verticalSpace(20),
              Text(
                'Post a Product',
                style: TextStyle(fontSize: 26),
              ),
              verticalSpaceMedium,
              InputField(
                placeholder: 'Name',
                controller: _missionController,
              ),
              verticalSpaceMedium,
              InputField(
                placeholder: 'Description',
                controller: _missionDescriptionController,
              ),
              verticalSpaceMedium,
              Text('Product Image'),
              verticalSpaceSmall,
              GestureDetector(
                onTap: () => model.selectImageGallery(),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: model.selectedImage == null
                      ? Text(
                          'Tap to add Product image',
                          style: TextStyle(color: Colors.grey[400]),
                        )
                      : Image.file(model.selectedImage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
