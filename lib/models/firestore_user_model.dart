import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

// part 'firestore_user_model.g.dart';

@HiveType(typeId: 1)
class FirestoreUser {
  @HiveField(0)
  final String id;

  final String email;

  @HiveField(1)
  String username;

  String userRole;

  @HiveField(2)
  String tasksCompleted;

  /// Merchant only
  @HiveField(3)
  String bio;

  @HiveField(4)
  String photoUrl;

  FirestoreUser({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.userRole,
    this.tasksCompleted,
    this.photoUrl,
    this.bio,
  });

  FirestoreUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        email = data['email'],
        userRole = data['userRole'],
        username = data['username'],
        tasksCompleted = data['tasksCompleted'],
        photoUrl = data['photoUrl'],
        bio = data['bio'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userRole': userRole,
      'username': username,
      'tasksCompleted': '0',
      'photoUrl': '',
      'bio': 'Welcome to Slick!',
    };
  }
}
