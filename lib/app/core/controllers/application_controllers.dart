import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/services/session_serivce.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/profile_repository.dart';

class ApplicationControllers extends GetxController {
  final ProfileRepository repository;
  ApplicationControllers({required this.repository});
  Rxn<AccountBillModel> accountbillData = Rxn<AccountBillModel>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final current = Get.currentRoute;
    if (current != '/login') {
      changeToken();
      getData();
    }
    // everAll([Get.routing.obs], (_) {
    //   final current = Get.currentRoute;
    //   final previous = Get.previousRoute;

    //   if (previous == '/login' && current == '/home') {
    //     changeToken();
    //     getData();
    //   }
    // });
  }

  Future<void> getData() async {
    try {
      isLoading(true);
      final result = await repository.getProfile();
      if (result != null) {
        accountbillData.value = result;
        Get.find<SessionService>().setUser(accountbillData.value!);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Helper().AlertSnackBar();
      return;
    }
  }

  Future<dynamic> changeToken() async {
    try {
      await repository.updateDataTokenFCM();
      return true;
    } catch (e) {
      print('harusnya error');
      Helper().AlertSnackBar();
    }
  }

  void clearProfile() {
    accountbillData.value = null;
    Get.find<SessionService>().clear();
  }
}
