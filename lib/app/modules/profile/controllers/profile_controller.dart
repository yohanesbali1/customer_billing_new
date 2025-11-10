import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/repositories/auth_repositories.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';

class ProfileController extends GetxController {
  final AuthRepository repository;
  final ApplicationControllers application_c =
      Get.find<ApplicationControllers>();
  final HomeController home_c = Get.find<HomeController>();

  ProfileController({required this.repository});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<dynamic> logoutData() async {
    try {
      Helper().AlertGetX('loading', null);
      await repository.logoutData();
      Get.offAllNamed('/login');
      Get.back();
    } catch (e) {
      Get.back();
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }
}
