import 'package:vigo_customer_billing/app/modules/error/views/error_page.dart';
import 'package:vigo_customer_billing/app/modules/error/views/no_internet_page.dart';
import 'package:get/get.dart';

class ErrorRoutes {
  ErrorRoutes._();

  static final routes = [
    GetPage(name: '/error', page: () => const ErrorPage()),
    GetPage(name: '/no_internet', page: () => const NoInternetPage()),
  ];
}
