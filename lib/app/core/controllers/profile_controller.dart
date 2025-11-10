import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/core/services/session_serivce.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;

  ProfileController({required this.repository});

  // Rxn<ProfileModel> user = Rxn<ProfileModel>();
  Rxn<AccountBillModel> accountbillData = Rxn<AccountBillModel>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getProfile();
    changeToken();
  }

  // Future<dynamic> getProfile() async {
  //   try {
  //     final result = await repository.getProfile();
  //     if (result != null) {
  //       user.value = result;
  //       Get.find<SessionService>().setUser(result);
  //     }
  //   } catch (e) {
  //     Helper().AlertSnackBar();
  //   }
  // }

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
      Helper().AlertSnackBar();
    }
  }

  void clearProfile() {
    accountbillData.value = null;
    Get.find<SessionService>().clear();
  }
}
