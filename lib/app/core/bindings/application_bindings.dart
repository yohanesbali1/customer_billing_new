import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/profile_controller.dart';
import 'package:vigo_customer_billing/app/core/services/local_storage_service.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
    Get.put(LocalStorageService(), permanent: true);
    Get.put(ProfileController(repository: Get.find()), permanent: true);
  }
}
