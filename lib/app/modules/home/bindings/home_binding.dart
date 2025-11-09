import 'package:vigo_customer_billing/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/history/history_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<DashboardController>(
      () => DashboardController(repository: Get.find()),
    );
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<HelpController>(() => HelpController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
