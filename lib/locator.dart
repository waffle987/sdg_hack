import 'package:get_it/get_it.dart';
import 'package:sdg_hack/services/authentication_service.dart';
import 'package:sdg_hack/services/dialog_service.dart';
import 'package:sdg_hack/services/firebase_cloud_storage_service.dart';
import 'package:sdg_hack/services/firestore_service.dart';
import 'package:sdg_hack/services/navigation_service.dart';
import 'package:sdg_hack/utils/image_selector.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
}
