import 'package:customer_billing/app/data/services/notification_service.dart';
import 'package:customer_billing/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  await Firebase.initializeApp();
  await NotificationService.instance.initialize();
  final storage = new FlutterSecureStorage();
  await dotenv.load();
  final String? token = await storage.read(key: 'token');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        // navigatorKey: navigatorKey,
        initialBinding: ApplicationBindings(),
        initialRoute: token != null ? '/home' : 'login',
        getPages: AppPages.routes,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          primaryColor: Color(0xFFBD0000),
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Color(0xFFBD0000),
            selectionColor: Color.fromARGB(255, 215, 39, 39),
            selectionHandleColor: Colors.transparent,
          ),
          textTheme: GoogleFonts.montserratTextTheme(
            // Use this within the builder context
            ThemeData.light().textTheme,
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
