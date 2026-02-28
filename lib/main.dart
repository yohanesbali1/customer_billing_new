// import 'package:firebase_core/firebase_core.dart'; // Commented out to avoid app hang
// import 'firebase_options.dart'; // Commented out to avoid app hang
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vigo_billing/firebase_options.dart';
// import 'package:google_fonts/google_fonts.dart'; // Temporarily disabled to avoid AssetManifest loading issues
import 'app/core/bindings/application_bindings.dart';
import 'app/core/global_keys.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vigo_billing/app/core/services/notification_service.dart';

// final navigatorKey = GlobalKey<NavigatorState>();

class NoStretchScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  await dotenv.load();

  // Initialize Firebase and notifications in background (non-blocking)
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) {
    NotificationService.instance.initialize();
  }).catchError((e) {
    // Firebase initialization error - ignored
  });
  final String? token = await storage.read(key: 'token');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'App Vigo Customer Billing',
        // navigatorKey: navigatorKey,
        initialBinding: ApplicationBindings(),
        initialRoute: token != null ? '/home' : '/login',
        getPages: AppPages.routes,
        theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.amber,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xFFEF8200),
            selectionColor: Colors.amber,
            selectionHandleColor: Colors.transparent,
          ),
        ),
        // scrollBehavior: NoStretchScrollBehavior(),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: NoStretchScrollBehavior(),
            child: child!,
          );
        },
      ),
    );
  });
}
