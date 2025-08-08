import 'package:customer_billing/app/modules/auth/middleware/auth_middleware.dart';
import 'package:customer_billing/app/modules/faq/faq_bindding.dart';
import 'package:customer_billing/app/modules/faq/faq_page.dart';
import 'package:get/get.dart';

class FAQRoutes {
  FAQRoutes._();

  static final routes = [
    GetPage(
      name: '/faq',
      page: () => const FAQPage(),
      binding: FAQBindding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
