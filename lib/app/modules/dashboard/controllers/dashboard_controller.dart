import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/controllers/application_controllers.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/repositories/dashborad_repository.dart';
import 'package:vigo_customer_billing/app/modules/home/controllers/home_controller.dart';

class DashboardController extends GetxController {
  final DashboardRepository? repository;
  DashboardController({this.repository});

  final home_c = Get.find<HomeController>();
  final application_c = Get.find<ApplicationControllers>();

  var total_unread = 0.obs;
  var isLoading = false.obs;

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

  Future<dynamic> getData() async {
    try {
      isLoading.value = true;
      final res = await repository!.getData();
      total_unread.value = res.total_unread ?? 0;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }
}
