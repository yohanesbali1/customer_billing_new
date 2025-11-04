import 'package:vigo_customer_billing/app/modules/auth/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/package/package_bindding.dart';
import 'package:vigo_customer_billing/app/modules/package/package_page.dart';
import 'package:get/get.dart';

class PackageRoutes {
  PackageRoutes._();

  static final routes = [
    GetPage(
      name: '/package/detail/',
      page: () => const PackagePage(),
      binding: PackageBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
