import 'package:vigo_customer_billing/app/modules/about/about_controller.dart';
import 'package:get/get.dart';

class AboutBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
