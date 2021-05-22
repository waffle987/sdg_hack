import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/dialog_service.dart';
import 'package:sdg_hack/services/firebase_cloud_storage_service.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';
import 'package:sdg_hack/utils/image_selector.dart';
import 'package:uuid/uuid.dart';

class MerchantUploadProductViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final DialogService _dialogService = locator<DialogService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Future selectImageGallery() async {
    var tempImage = await _imageSelector.selectImageGallery();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  void setModelBusy() {
    setBusy(true);
  }

  void setModelNotBusy() {
    setBusy(false);
  }

  void showErrorDialog() async {
    await _dialogService.showDialog(
      title: 'Unable to list Product',
      description: 'There are fields that are incomplete',
    );
  }

  void uploadProduct({
    @required String name,
    @required String description,
    @required String currentUserId,
  }) async {
    CloudStorageResult storageResult;
    String _productId = Uuid().v4();

    if (selectedImage != null) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        fileName: _productId,
      );
    }

    _firestoreService.addProduct(
      merchantId: currentUserId,
      name: name,
      description: description,
      photoUrl: selectedImage != null ? storageResult.imageUrl : '',
      fileName: selectedImage != null ? storageResult.imageFileName : '',
      productId: _productId,
    );

    _navigationService.pop();
  }
}
