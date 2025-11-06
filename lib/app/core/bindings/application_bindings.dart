import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/error/controllers/error_controller.dart';
import 'package:vigo_customer_billing/app/modules/error/controllers/network_controller.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController(), permanent: true);
    Get.put(ErrorController(), permanent: true);
  }
}
