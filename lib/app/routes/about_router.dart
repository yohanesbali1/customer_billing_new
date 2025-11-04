import 'package:vigo_customer_billing/app/modules/about/about_bindding.dart';
import 'package:vigo_customer_billing/app/modules/about/about_page.dart';
import 'package:get/get.dart';

class AboutRoutes {
  AboutRoutes._();

  static final routes = [
    GetPage(
      name: '/about/app',
      page: () => const AboutPage(),
      binding: AboutBinding(),
    ),
  ];
}
