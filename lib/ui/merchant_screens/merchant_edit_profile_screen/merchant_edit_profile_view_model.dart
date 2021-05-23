import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sdg_hack/config/boxes.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/firebase_cloud_storage_service.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';
import 'package:sdg_hack/utils/image_selector.dart';

class MerchantEditProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File get selectedImage => _selectedImage;

  void uploadProfilePicture() async {
    setBusy(true);

    final authBox = Boxes.getCurrentUserBox();
    final FirestoreUser currentUser = authBox.get(0);

    CloudStorageResult storageResult;

    storageResult = await _cloudStorageService.uploadImage(
      imageToUpload: _selectedImage,
      fileName: currentUser.id,
    );

    _firestoreService.updateProfilePhotoUrl(
      user: currentUser,
      photoUrl: storageResult.imageUrl,
    );

    currentUser.photoUrl = storageResult.imageUrl;

    authBox.putAt(0, currentUser);

    setBusy(false);

    _navigationService.pop();
  }

  Future selectImage({@required bool isCamera}) async {
    var tempImage = isCamera
        ? await _imageSelector.selectImageCamera()
        : await _imageSelector.selectImageGallery();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  FirestoreUser getCurrentProviderUserModel() {
    return _authenticationService.currentUser;
  }

  Future<bool> updateUsername({
    @required String username,
    @required FirestoreUser currentUser,
  }) {
    return _firestoreService.merchantUpdateUsername(
      user: currentUser,
      username: username,
    );
  }

  void updateBio({
    @required String bio,
    @required FirestoreUser currentUser,
  }) {
    _firestoreService.updateBio(
      user: currentUser,
      bio: bio,
    );
  }

  void navigationPop() {
    _navigationService.pop();
  }

  void navigateTo({@required String routeName}) {
    _navigationService.navigateTo(routeName);
  }
}
