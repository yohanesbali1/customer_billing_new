import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/services/local_storage_service.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
    Get.put(LocalStorageService(), permanent: true);
    Get.put(ApplicationControllers(repository: Get.find()), permanent: true);
  }
}
