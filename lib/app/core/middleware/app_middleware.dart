import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/modules/error/controllers/error_controller.dart';
import 'package:vigo_customer_billing/app/modules/error/controllers/network_controller.dart';

class AppGuardMiddleware extends GetMiddleware {
  final storage = const FlutterSecureStorage();

  @override
  Future<RouteSettings?> redirectFuture(String? route) async {
    // ✅ Skip halaman login
    if (route == '/login') return null;

    final network = Get.find<NetworkController>();
    final error = Get.find<ErrorController>();

    // ✅ 1. Cek token login
    final token = await storage.read(key: 'token');
    if (token == null || token.isEmpty) {
      return const RouteSettings(name: '/login');
    }

    // ✅ 2. Cek koneksi internet
    if (!network.isConnected.value) {
      return const RouteSettings(name: '/no_internet');
    }

    // ✅ 3. Cek error global
    if (error.hasError.value) {
      return const RouteSettings(name: '/error');
    }

    // ✅ Lanjut ke halaman normal
    return null;
  }
}
