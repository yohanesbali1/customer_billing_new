import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/package/binddings/package_bindding.dart';
import 'package:vigo_customer_billing/app/modules/package/views/package_page.dart';
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
