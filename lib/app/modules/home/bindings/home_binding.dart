import 'package:vigo_customer_billing/app/data/repositories/auth_repositories.dart';
import 'package:vigo_customer_billing/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/controllers/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';
import 'package:vigo_customer_billing/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:vigo_customer_billing/app/modules/profile/controllers/profile_controller.dart';
import 'package:vigo_customer_billing/app/data/repositories/help_repository.dart';
import 'package:vigo_customer_billing/app/data/repositories/invoice_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //repository
    Get.lazyPut<InvoiceRepository>(
      () => InvoiceRepository(api: Get.find()),
      fenix: true,
    );
    Get.lazyPut<HelpRepository>(
      () => HelpRepository(api: Get.find()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(api: Get.find()),
      fenix: true,
    );

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<InvoiceController>(
      () => InvoiceController(repository: Get.find()),
    );
    Get.lazyPut<HelpController>(() => HelpController(repository: Get.find()));
    Get.lazyPut<ProfileController>(
      () => ProfileController(repository: Get.find()),
    );
  }
}
