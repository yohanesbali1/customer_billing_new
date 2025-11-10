import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/controlllers/help_detail_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpFormController>(
      () => HelpFormController(
        repository: Get.find(),
        mapsRepository: Get.find(),
      ),
    );
    Get.lazyPut<HelpDetailController>(
      () => HelpDetailController(repository: Get.find()),
    );
  }
}
