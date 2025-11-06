import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/service/service_bindding.dart';
import 'package:vigo_customer_billing/app/modules/service/service_page.dart';
import 'package:get/get.dart';

class ServiceRoutes {
  ServiceRoutes._();

  static final routes = [
    GetPage(
      name: '/service',
      page: () => const ServicePage(),
      binding: ServiceBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
