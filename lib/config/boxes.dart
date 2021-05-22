import 'package:hive/hive.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';

class Boxes {
  /// Get the current user box
  static Box<FirestoreUser> getCurrentUserBox() => Hive.box('auth');
}
