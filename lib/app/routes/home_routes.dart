import 'package:customer_billing/app/modules/auth/middleware/auth_middleware.dart';
import 'package:customer_billing/app/modules/home/home_binding.dart';
import 'package:customer_billing/app/modules/home/home_page.dart';
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
