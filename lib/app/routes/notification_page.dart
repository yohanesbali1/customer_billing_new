import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/notification/binddings/notification_bindding.dart';
import 'package:vigo_customer_billing/app/modules/notification/views/nofication_view.dart';

class NotificationRoutes {
  NotificationRoutes._();

  static final routes = [
    GetPage(
      name: '/notification',
      page: () => const NotificationPage(),
      binding: NotificationBindding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
