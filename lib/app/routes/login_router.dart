import 'package:vigo_customer_billing/app/modules/login/binddings/login_binding.dart';
import 'package:vigo_customer_billing/app/modules/login/views/login_page.dart';
import 'package:get/get.dart';

class LoginRoutes {
  LoginRoutes._();

  static const home = '/login';

  static final routes = [
    GetPage(name: home, page: () => LoginPage(), binding: LoginBinding()),
  ];
}
