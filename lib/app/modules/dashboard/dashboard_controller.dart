import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/modules/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement HomeController.
  Rxn<AccountBillModel> accountbillData = Rxn<AccountBillModel>();
  var isLoading = true.obs;
  final auth_c = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    auth_c.getData();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      accountbillData.value = await AccountBillProvider().getData();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Helper().AlertSnackBar();
    }
  }
}
