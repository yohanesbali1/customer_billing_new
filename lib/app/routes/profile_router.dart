import 'package:vigo_customer_billing/app/modules/auth/middleware/auth_middleware.dart';
import 'package:vigo_customer_billing/app/modules/profile/detail_profile/detail_profile_bindding.dart';
import 'package:vigo_customer_billing/app/modules/profile/detail_profile/detail_profile_page.dart';
import 'package:vigo_customer_billing/app/modules/profile/information/information_bindding.dart';
import 'package:vigo_customer_billing/app/modules/profile/information/information_page.dart';
import 'package:vigo_customer_billing/app/modules/profile/setting/setting_page.dart';
import 'package:vigo_customer_billing/app/modules/profile/update_password/update_password_bindding.dart';
import 'package:vigo_customer_billing/app/modules/profile/update_password/update_password_page.dart';
import 'package:get/get.dart';

class ProfileRoutes {
  ProfileRoutes._();

  static final routes = [
    GetPage(
      name: '/profile/detail',
      page: () => const DetailProfilePage(),
      binding: DetailProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/profile/update-password',
      page: () => UpdatePasswordPage(),
      binding: UpdatePasswordBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/profile/information',
      page: () => const InformationPage(),
      binding: InformationBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/profile/setting',
      page: () => const SettingProfilePage(),
      binding: DetailProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
