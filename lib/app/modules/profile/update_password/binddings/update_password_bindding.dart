import 'package:vigo_customer_billing/app/modules/profile/update_password/controllers/update_password_controller.dart';
import 'package:get/get.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordController>(
      () => UpdatePasswordController(repository: Get.find()),
    );
  }
}
