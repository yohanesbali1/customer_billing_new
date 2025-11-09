import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(repository: Get.find()));
  }
}
