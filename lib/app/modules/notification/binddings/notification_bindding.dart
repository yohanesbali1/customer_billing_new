import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/repositories/notification_repositoriy.dart';
import 'package:vigo_customer_billing/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vigo_customer_billing/app/modules/notification/controllers/notification_controller.dart';

class NotificationBindding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationRepositoriy>(
      () => NotificationRepositoriy(api: Get.find()),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        repository: Get.find<NotificationRepositoriy>(),
      ),
    );
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
