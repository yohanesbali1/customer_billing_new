import 'package:customer_billing/app/modules/faq/faq_controller.dart';
import 'package:get/get.dart';

class FAQBindding extends Bindings {
  void dependencies() {
    Get.lazyPut<FAQController>(() => FAQController());
  }
}
