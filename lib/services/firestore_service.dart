import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/models/product_model.dart';

class FirestoreService {
  /// Stream controllers
  final StreamController<List<ProductModel>> _productController =
      StreamController<List<ProductModel>>.broadcast();
  final StreamController<List<FirestoreUser>> _merchantListController =
      StreamController<List<FirestoreUser>>.broadcast();

  final CollectionReference _merchantPostsCollectionReference =
      FirebaseFirestore.instance.collection('merchant posts');
  final CollectionReference _merchantsCollectionReference =
      FirebaseFirestore.instance.collection('merchants');
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  /// MERCHANT PROFILE
  /// Update merchant photo url
  void updateProfilePhotoUrl({
    @required FirestoreUser user,
    @required String photoUrl,
  }) {
    _userCollectionReference.doc(user.id).update({
      'photoUrl': photoUrl,
    });

    _merchantsCollectionReference.doc(user.id).update({
      'photoUrl': photoUrl,
    });
  }

  /// Update merchant bio
  void updateBio({
    @required FirestoreUser user,
    @required String bio,
  }) {
    _userCollectionReference.doc(user.id).update({
      'bio': bio,
    });

    _merchantsCollectionReference.doc(user.id).update({
      'bio': bio,
    });
  }

  /// Update Merchant username
  Future<bool> merchantUpdateUsername({
    @required FirestoreUser user,
    @required String username,
  }) {
    return _userCollectionReference
        .where('username', isEqualTo: username)
        .get()
        .then((doc) {
      if (doc.docs.length > 0) {
        return false;
      } else {
        _userCollectionReference.doc(user.id).update({
          'username': username,
        });

        _merchantsCollectionReference.doc(user.id).update({
          'username': username,
        });
        return true;
      }
    });
  }

  /// Check username ("True" == valid username)
  Future<bool> checkUsername({@required String username}) {
    return _userCollectionReference
        .where('username', isEqualTo: username)
        .get()
        .then((doc) {
      if (doc.docs.length > 0) {
        return false;
      } else {
        return true;
      }
    });
  }

  /// Update User username
  Future<bool> userUpdateUsername({
    @required FirestoreUser user,
    @required String username,
  }) {
    return _userCollectionReference
        .where('username', isEqualTo: username)
        .get()
        .then((doc) {
      if (doc.docs.length > 0) {
        return false;
      } else {
        _userCollectionReference.doc(user.id).update({
          'username': username,
        });
        return true;
      }
    });
  }

  /// Listen to stream of rewards
  Stream<List<ProductModel>> listenToProductsRealTime(
      {@required String merchantId}) {
    _merchantPostsCollectionReference
        .doc(merchantId)
        .collection('products')
        .snapshots()
        .listen((productSnapshot) {
      if (productSnapshot.docs.isNotEmpty) {
        List<ProductModel> _rewards = productSnapshot.docs.length == 0
            ? []
            : productSnapshot.docs
                .map((doc) => ProductModel.fromDocument(doc: doc))
                .toList();
        _productController.add(_rewards);
      }
    });

    return _productController.stream;
  }

  /// MERCHANT UPLOAD CONTENT
  /// Create a mission in Firestore
  void addProduct({
    @required String merchantId,
    @required String name,
    @required String description,
    @required String photoUrl,
    @required String fileName,
    @required String productId,
  }) {
    _merchantPostsCollectionReference
        .doc(merchantId)
        .collection('products')
        .doc(productId)
        .set({
      "name": name,
      "description": description,
      "photoUrl": photoUrl,
      "productId": productId,
      "fileName": fileName,
    });
  }

  /// Listen to stream of merchants
  Stream<List<FirestoreUser>> listenToMerchantsRealTime() {
    _merchantsCollectionReference.snapshots().listen((merchantsSnapshot) {
      if (merchantsSnapshot.docs.isNotEmpty) {
        List<FirestoreUser> _merchants = merchantsSnapshot.docs.length == 0
            ? []
            : merchantsSnapshot.docs
                .map((doc) => FirestoreUser.fromData(doc.data()))
                .toList();
        _merchantListController.add(_merchants);
      }
    });

    return _merchantListController.stream;
  }
}
