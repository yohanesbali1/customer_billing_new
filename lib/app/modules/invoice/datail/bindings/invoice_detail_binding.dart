import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/data/repositories/invoice_repository.dart';
import 'package:vigo_customer_billing/app/modules/invoice/datail/controllers/invoice_detail_controller.dart';

class InvoiceDetailBinding extends Bindings {
  void dependencies() {
    Get.put<InvoiceRepository>(InvoiceRepository(api: Get.find()));
    Get.lazyPut<InvoiceDetailController>(
      () => InvoiceDetailController(
        repository: Get.find(),
        bankRepository: Get.find(),
      ),
    );
  }
}
