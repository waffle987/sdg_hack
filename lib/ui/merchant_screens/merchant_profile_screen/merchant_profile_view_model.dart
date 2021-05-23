import 'package:flutter/cupertino.dart';
import 'package:sdg_hack/config/route_names.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/product_model.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/dialog_service.dart';
import 'package:sdg_hack/services/firebase_cloud_storage_service.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';

class MerchantProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<ProductModel> _products;
  List<ProductModel> get products => _products;

  void listenToProducts({@required String merchantId}) {
    setBusy(true);

    _firestoreService
        .listenToProductsRealTime(
            merchantId: merchantId != '' ? merchantId : '')
        .listen((productsData) {
      List<ProductModel> updatedProducts = productsData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _products = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  void navigateToEditProfilePage() {
    _navigationService.navigateTo(RouteNames.MerchantEditProfilePageRoute);
  }

  void logout({@required BuildContext dialogContext}) async {
    setBusy(true);
    await _authenticationService.logout();
    setBusy(false);

    Navigator.pop(dialogContext);

    _navigationService.navigateReplacementTo(RouteNames.LoginPageRoute);
  }

  Future deleteProducts({
    @required String documentId,
    @required String merchantId,
    @required String fileName,
    @required Function removeFromListFunction,
  }) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the Product?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteProducts(
        documentId: documentId,
        merchantId: merchantId,
      );

      if (fileName != '') {
        await _cloudStorageService.deleteImage(fileName);
      }

      removeFromListFunction();

      setBusy(false);
    }
  }
}
