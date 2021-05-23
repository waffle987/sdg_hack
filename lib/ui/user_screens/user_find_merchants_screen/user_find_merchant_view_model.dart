import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/providers/base_view_model.dart';
import 'package:sdg_hack/services/firestore_service.dart';

class UserFindMerchantViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<FirestoreUser> _merchants;
  List<FirestoreUser> get merchants => _merchants;

  void listenToMerchants() {
    setBusy(true);

    _firestoreService.listenToMerchantsRealTime().listen((merchantData) {
      List<FirestoreUser> updatedMerchants = merchantData;
      if (updatedMerchants != null && updatedMerchants.length > 0) {
        _merchants = updatedMerchants;
        notifyListeners();
      }
    });
    setBusy(false);
  }
}
