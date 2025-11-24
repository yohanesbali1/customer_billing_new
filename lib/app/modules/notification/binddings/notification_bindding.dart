import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/notification/controllers/notification_controller.dart';

class NotificationBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
