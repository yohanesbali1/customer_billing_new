import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final storage = new FlutterSecureStorage();
  @override
  RouteSettings? redirect(String? route) {
    storage.read(key: 'token').then((token) {
      if (token == "") {
        return RouteSettings(name: '/login');
      }
      return null;
    });
  }
}
