import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final isConnected = true.obs;
  final _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _checkInitial();
    _connectivity.onConnectivityChanged.listen((status) {
      isConnected.value = status != ConnectivityResult.none;
    });
  }

  Future<void> _checkInitial() async {
    final status = await _connectivity.checkConnectivity();
    isConnected.value = status != ConnectivityResult.none;
  }
}
