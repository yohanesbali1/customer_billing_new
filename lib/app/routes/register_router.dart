import 'package:vigo_customer_billing/app/core/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/register/page/register_alert.dart';
import 'package:vigo_customer_billing/app/modules/register/page/register_profile.dart';
import 'package:vigo_customer_billing/app/modules/register/page/register_upload.dart';
import 'package:vigo_customer_billing/app/modules/register/register_binding.dart';
import 'package:get/get.dart';

class RegisterRoutes {
  RegisterRoutes._();

  static final routes = [
    GetPage(
      name: '/register',
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/register/path',
      page: () => const RegisterPathPage(),
      binding: RegisterBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/register/alert',
      page: () => const RegisteAlertPage(),
      binding: RegisterBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
