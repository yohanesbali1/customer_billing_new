import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/repositories/help_repository.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vigo_customer_billing/app/modules/help/controllers/help_controller.dart';

class HelpDetailController extends GetxController {
  final HelpRepository repository;
  HelpDetailController({required this.repository});
  final HelpController helpController = Get.find<HelpController>();
  var isLoading = false.obs;
  var id = ''.obs;
  Rxn<HelpModel?> reportData = Rxn<HelpModel?>();

  @override
  void onInit() {
    super.onInit();
    id.value = Get.parameters['id'] ?? '';
    if (id.value.isNotEmpty) getData(id.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    reportData.value = null;
  }

  @override
  Future<dynamic> getData(String id) async {
    try {
      isLoading.value = true;
      reportData.value = await repository.showHelpData(id);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }

  @override
  Future<dynamic> deleteData() async {
    try {
      isLoading.value = true;
      Helper().AlertGetX(type: 'loading');
      await repository.deleteHelp(id.value);
      reportData.value = null;
      await helpController.getData();
      Get.back();
      await Helper().AlertGetX(
        type: 'success',
        message: "Data berhasil dihapus",
      );
      Get.back();
      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }

  Future<dynamic> openWebsite(data) async {
    try {
      var parts = data!.maps!.split(',');
      if (parts.length <= 1) {
        String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
        Helper().AlertGetX(message: errorMessage);

        return;
      }

      final gmaps =
          "https://www.google.com/maps?q=${double.parse(parts[0])},${double.parse(parts[1])}";
      final Uri uri = Uri.parse(gmaps);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
        Helper().AlertGetX(message: errorMessage);
        return;
      }
    } catch (e) {
      String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }
}
