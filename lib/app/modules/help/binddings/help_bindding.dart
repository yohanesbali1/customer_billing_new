import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/repositories/help_repository.dart';
import 'package:vigo_customer_billing/app/data/repositories/maps_repository.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/controlllers/help_detail_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/form/controllers/help_form_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpRepository>(() => HelpRepository(api: Get.find()));
    Get.lazyPut<MapsRepository>(() => MapsRepository(api: Get.find()));
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
