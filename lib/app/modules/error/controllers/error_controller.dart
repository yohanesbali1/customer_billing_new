import 'package:get/get.dart';

class ErrorController extends GetxController {
  final hasError = false.obs;
  final errorMessage = ''.obs;

  void setError(String message) {
    hasError.value = true;
    errorMessage.value = message;
  }

  void clearError() {
    hasError.value = false;
    errorMessage.value = '';
  }
}
