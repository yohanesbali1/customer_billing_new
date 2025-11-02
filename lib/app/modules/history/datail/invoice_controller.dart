import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var id = ''.obs;
  Rxn<InvoiceModel?> invoiceData = Rxn<InvoiceModel?>();
  Rxn<BankModel?> bank_data = Rxn<BankModel?>();
  var list_bank = <BankGroupModel>[].obs;
  var isLoading = false.obs;
  var isLoadingBank = false.obs;
  var bank_value = false.obs;
  var isButtonDisabledCopy = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Safely get the parameter 'id' from the Get.parameters map
    id.value =
        Get.parameters['id'] ??
        ''; // Defaulting to empty string if 'id' is not found
    getData(id.value);
    getBank();
  }

  @override
  Future<void> getData(payload) async {
    try {
      isLoading.value = true;
      invoiceData.value = await InvoiceProvider().showinvoiceData(payload);
      invoiceData.value!.paymentMethod != null
          ? showBank(invoiceData.value!.paymentMethod)
          : null;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Helper().AlertSnackBar();
    }
  }

  @override
  Future<void> showBank(id) async {
    try {
      isLoading.value = true;
      bank_data.value = await BankProvider().showData(id);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Helper().AlertSnackBar();
    }
  }

  @override
  Future<void> getBank() async {
    try {
      isLoadingBank.value = true;
      list_bank.value = await BankProvider().getData();
      isLoadingBank.value = false;
    } catch (e) {
      isLoadingBank.value = false;
      Helper().AlertSnackBar();
    }
  }

  String change_status(status) {
    switch (status) {
      case 'not_paid':
        return 'Belum Dibayar';
      case 'paid':
        return 'Sudah Dibayar';
      default:
        return '-';
    }
  }

  String bank_group(status) {
    switch (status) {
      case 'va':
        return 'Virtual Account';
      case 'manual':
        return 'Transfer Manual';
      default:
        return 'Cash';
    }
  }

  choses_bank(data) {
    bank_data.value = data;
  }
}
