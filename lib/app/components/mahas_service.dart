import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project_tes2/app/components/mahas_colors.dart';

// final authController = AuthController.instance;
// final remoteConfig = FirebaseRemoteConfig.instance;
// final auth = FirebaseAuth.instance;
// final splashController = SplashScreenController.instance;
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

class MahasService {
  // static Future<void> backgroundHandler(RemoteMessage message) async {}

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // transparent status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    //easyloading
    EasyLoading.instance.dismissOnTap = true;

    //firebase
    // await checkFirebase();

    //easyloading
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.dark
      ..radius = 10
      ..progressColor = MahasColors.primary
      ..backgroundColor = MahasColors.dark
      ..indicatorColor = MahasColors.primary
      ..textColor = MahasColors.light
      ..maskColor = MahasColors.dark.withValues(alpha: 0.3)
      ..maskType = EasyLoadingMaskType.custom
      ..textColor = MahasColors.primary
      ..userInteractions = false
      ..indicatorSize = 30
      ..dismissOnTap = true;

    // HttpOverrides.global = MyHttpOverrides();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
