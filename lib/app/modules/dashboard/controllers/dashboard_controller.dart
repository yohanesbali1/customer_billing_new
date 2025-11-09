import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/providers/providers.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/repositories/account_bill_repositories.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final AccountBillRepository repository;
  DashboardController({required this.repository});

  Rxn<AccountBillModel> accountbillData = Rxn<AccountBillModel>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
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
      return;
    }
  }
}
