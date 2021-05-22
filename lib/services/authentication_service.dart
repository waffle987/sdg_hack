import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';

class AuthenticationService {
  /// Collection references

  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _merchantsCollectionReference =
      FirebaseFirestore.instance.collection('merchants');

  /// Firebase Auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirestoreUser _currentUser;
  FirestoreUser get currentUser => _currentUser;

  /// Get Firestore user

  Future getUser({String uid}) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return FirestoreUser.fromData(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  /// Create user in Firestore

  Future createUser(FirestoreUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());

      if (user.userRole == 'Merchant') {
        await _merchantsCollectionReference.doc(user.id).set(user.toJson());
      }
    } catch (e) {
      return e.message;
    }
  }

  /// Check if the user is logged in already

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User authUser) async {
    if (authUser != null) {
      _currentUser = await getUser(uid: authUser.uid);
    }
  }

  /// Check if the user is a merchant

  bool isMerchant() {
    return _currentUser.userRole == 'Merchant';
  }

  /// Email verification logic

  Future<bool> isEmailVerified() async {
    var user = _firebaseAuth.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }

    return user.emailVerified;
  }

  /// Login with email logic

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  /// Sign up with email logic

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String username,
    @required String role,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// Create a new user profile on firestore

      _currentUser = FirestoreUser(
        id: authResult.user.uid,
        email: email,
        username: username,
        userRole: role,
      );

      await createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  /// Log out logic

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
