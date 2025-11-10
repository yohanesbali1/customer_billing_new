import 'package:vigo_customer_billing/app/data/repositories/invoice_repository.dart';
import 'package:vigo_customer_billing/app/modules/help/controllers/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';
import 'package:vigo_customer_billing/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put(InvoiceRepository(api: Get.find()));
    Get.lazyPut<InvoiceController>(
      () => InvoiceController(repository: Get.find()),
    );
    Get.lazyPut<HelpController>(() => HelpController(repository: Get.find()));
    Get.lazyPut<ProfileController>(
      () => ProfileController(repository: Get.find()),
    );
  }
}
