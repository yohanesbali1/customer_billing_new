import 'package:vigo_customer_billing/app/modules/package/controlllers/package_controller.dart';
import 'package:get/get.dart';

class PackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageController>(() => PackageController());
  }
}
