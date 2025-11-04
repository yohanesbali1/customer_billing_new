import 'package:vigo_customer_billing/app/modules/dashboard/dashboard_controller.dart';
import 'package:vigo_customer_billing/app/modules/history/datail/invoice_controller.dart';
import 'package:get/get.dart';

class InvoiceBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
