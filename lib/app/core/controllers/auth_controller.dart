import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  final isLoggedIn = false.obs;
  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final success = await repository.login(email, password);
      if (success) {
        isLoggedIn.value = true;
        Get.offAllNamed('/dashboard');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await repository.logout();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  Future<void> checkLoginStatus() async {
    final loggedIn = await repository.isLoggedIn();
    isLoggedIn.value = loggedIn;
    if (loggedIn) {
      Get.offAllNamed('/dashboard');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
