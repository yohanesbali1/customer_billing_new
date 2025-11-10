import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/services/local_storage_service.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';
import 'package:vigo_customer_billing/app/data/repositories/profile_repository.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ProfileRepository(api: Get.find()), permanent: true);
    Get.put(LocalStorageService(), permanent: true);
    Get.put(ApplicationControllers(repository: Get.find()), permanent: true);
  }
}
