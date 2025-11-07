import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/update_password/update_password_controller.dart';
import 'package:get/get.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(() => UpdatePasswordController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
