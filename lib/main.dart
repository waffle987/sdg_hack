import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sdg_hack/locator.dart';
import 'package:sdg_hack/managers/dialog_manager.dart';
import 'package:sdg_hack/models/firestore_user_model.dart';
import 'package:sdg_hack/router.dart';
import 'package:sdg_hack/ui/startup_screen/startup_screen.dart';

import 'services/dialog_service.dart';
import 'services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Initialise Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FirestoreUserAdapter());
  await Hive.openBox<FirestoreUser>('auth');

  /// Set device always to portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDG Hack',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.white,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.red),
      ),
      home: StartUpPage(),
      navigatorKey: locator<NavigationService>().navigationKey,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
