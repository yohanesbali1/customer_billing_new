import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';

class DashboardController extends GetxController {
  DashboardController();
  final home_c = Get.find<HomeController>();
  final application_c = Get.find<ApplicationControllers>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
