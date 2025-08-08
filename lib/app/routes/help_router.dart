import 'package:customer_billing/app/modules/auth/middleware/auth_middleware.dart';
import 'package:customer_billing/app/modules/help/help_bindding.dart';
import 'package:customer_billing/app/modules/help/page/help_chat_page.dart';
import 'package:customer_billing/app/modules/help/page/help_detail_page.dart';
import 'package:customer_billing/app/modules/help/page/help_form_page.dart';
import 'package:customer_billing/app/modules/help/page/list_help_page.dart';
import 'package:get/get.dart';

class HelpRoutes {
  HelpRoutes._();

  static final routes = [
    GetPage(
      name: '/help/detail/:id',
      page: () => DetailHelpPage(),
      binding: HelpBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/help/add',
      page: () => FormHelpPage(),
      binding: HelpBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/help/update/:id',
      page: () => FormHelpPage(),
      binding: HelpBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/help/chat/:id',
      page: () => ChatHelpPage(),
      binding: HelpBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
