import 'package:vigo_customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'detail_profile_controller.dart';

class DetailProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<DetailProfileController>(() => DetailProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
