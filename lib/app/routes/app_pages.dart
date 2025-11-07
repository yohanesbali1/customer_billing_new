import 'faq_router.dart';
import 'invoice_router.dart';
import 'help_router.dart';
import 'login_router.dart';
import 'profile_router.dart';
import 'register_router.dart';
import 'package_router.dart';
import 'home_routes.dart';
import 'service_router.dart';
import 'about_router.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/login';

  static final routes = [
    ...HomeRoutes.routes,
    ...LoginRoutes.routes,
    ...RegisterRoutes.routes,
    ...ProfileRoutes.routes,
    ...HelpRoutes.routes,
    ...InvoiceRoutes.routes,
    ...PackageRoutes.routes,
    ...ServiceRoutes.routes,
    ...AboutRoutes.routes,
    ...FAQRoutes.routes,
  ];
}
