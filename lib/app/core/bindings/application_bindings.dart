import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/providers/api_provider.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider(), permanent: true);
  }
}
