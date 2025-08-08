import 'package:customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:customer_billing/app/modules/dashboard/dashboard_controller.dart';
import 'package:customer_billing/app/modules/help/help_controller.dart';
import 'package:customer_billing/app/modules/history/history_controller.dart';
import 'package:customer_billing/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<HelpController>(() => HelpController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
