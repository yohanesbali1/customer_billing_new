import 'package:vigo_customer_billing/app/modules/home/bindings/home_binding.dart';
import 'package:vigo_customer_billing/app/modules/home/views/home_page.dart';
import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:get/get.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
