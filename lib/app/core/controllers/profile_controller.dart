import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/services/session_serivce.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;

  ProfileController({required this.repository});

  Rxn<ProfileModel> user = Rxn<ProfileModel>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      final result = await repository.getProfile();
      if (result != null) {
        user.value = result;
        Get.find<SessionService>().setUser(result);
      }
    } catch (e) {
      print('Get profile error: $e');
    }
  }

  void clearProfile() {
    user.value = null;
    Get.find<SessionService>().clear();
  }
}
