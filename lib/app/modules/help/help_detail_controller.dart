import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/modules/help/help_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDetailController extends GetxController {
  var isLoading = false.obs;
  var id = ''.obs;
  Rxn<ReportModelDetail?> reportData = Rxn<ReportModelDetail?>();
  final help_controller = Get.put(HelpController());

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  Future<void> getData() async {
    try {
      isLoading.value = true;
      id.value = Get.parameters['id'] ?? '';
      reportData.value = await HelperProvider().showreportData(id.value);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage =
          e is String ? e : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  @override
  deleteData() async {
    try {
      isLoading.value = true;
      Helper().AlertGetX('loading', null);
      await HelperProvider().deletereportData(id.value);
      help_controller.report_data.value = await HelperProvider().getData();
      Get.back();
      await Helper().AlertGetX('success', "Data berhasil dihapus");
      Get.back();
      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;
      String errorMessage =
          e is String ? e : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  void openWebsite(data) async {
    try {
      var parts = data!.maps!.split(',');
      if (parts.length <= 1) {
        String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
        Helper().AlertGetX(null, errorMessage);

        return;
      }

      final gmaps =
          "https://www.google.com/maps?q=${double.parse(parts[0])},${double.parse(parts[1])}";
      final Uri uri = Uri.parse(gmaps);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
        Helper().AlertGetX(null, errorMessage);
        return;
      }
    } catch (e) {
      String errorMessage = 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }
}
