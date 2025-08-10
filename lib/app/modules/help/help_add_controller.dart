import 'dart:io';

import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/data/models/models.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:customer_billing/app/modules/help/help_controller.dart';
import 'package:customer_billing/app/modules/help/help_detail_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class HelpFormController extends GetxController {
  var isLoading = false.obs;
  var isoptionLoading = false.obs;
  var id = ''.obs;
  Rxn<ReportModelDetail?> data = Rxn<ReportModelDetail?>();
  Rxn<TypeTopic?> type_topic_value = Rxn<TypeTopic?>();
  final formkey = GlobalKey<FormState>();
  var address = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var type_topic_id = TextEditingController().obs;
  int type_topic_select = 0;
  var description = TextEditingController().obs;
  var maps = TextEditingController().obs;
  var type_topic_data = <TypeTopic>[].obs;
  final detail_controller = Get.put(HelpDetailController());
  final help_controller = Get.put(HelpController());
  var currentPosition = Rxn<Position>();
  Rxn<LatLng> selectedLocation = Rxn<LatLng>();
  final MapController flutterMapController = MapController();
  final search = "".obs;
  var searchItem = <MapModel>[].obs;
  final picker = ImagePicker();
  var image = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    getData();
    debounce(search, (String value) async {
      await Future.delayed(Duration(milliseconds: 300)); // Optional delay
      getSearch(value);
    }, time: Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    flutterMapController.dispose();
    super.onClose();
  }

  clear_form() {
    address.value.clear();
    phone.value.clear();
    description.value.clear();
    maps.value.clear();
    type_topic_id.value.clear();
    image.value = null;
  }

  String? validator_input(value) {
    return value!.isEmpty ? 'Field ini harus diisi' : null;
  }

  getData() async {
    try {
      id.value = Get.parameters['id'] ?? '';
      isLoading.value = true;
      type_topic_data.value = await HelperProvider().get_type();
      if (id.value != '') {
        data.value = detail_controller.reportData.value;
        address.value.text = data.value!.address!;
        phone.value.text = data.value!.phone!;
        description.value.text = data.value!.description!;
        type_topic_id.value.text = data.value!.typeTopic!.type!;
        type_topic_value.value = data.value!.typeTopic!;
        var parts = data.value!.maps!.split(',');
        if (parts.length >= 2) {
          maps.value.text = data.value!.maps!;
          await updateLocation(
            LatLng(double.parse(parts[0]), double.parse(parts[1])),
          );
        }
      } else {
        await getCurrentLocation();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  submit_data() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var data = {
        "id": id.value,
        "form": {
          'phone': phone.value.text,
          'address': address.value.text,
          'maps':
              "${selectedLocation.value!.latitude},${selectedLocation.value!.longitude}",
          'type_topic_id': type_topic_value.value!.id.toString(),
          'description': description.value.text,
          'img': image.value,
        },
      };
      await HelperProvider().submitReportData(data);
      if (id.value == '') {
        help_controller.report_data.value = await HelperProvider().getData();
      } else {
        detail_controller.reportData.value = await HelperProvider()
            .showreportData(id.value);
      }
      Get.back();
      await Helper().AlertGetX('success', "Data berhasil disimpan");
      Get.back();
      isLoading(false);
    } catch (e) {
      Get.back();
      isLoading(false);
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  select_type_data() async {
    try {
      type_topic_value.value = type_topic_data.value[type_topic_select];
      type_topic_id.value.text = type_topic_value.value!.type.toString();
    } catch (e) {
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  getCurrentLocation() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          Helper().AlertGetX(null, 'Aktifkan akses lokasi di pengaturan');
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await updateLocation(LatLng(position.latitude, position.longitude));
      Get.back();
      isLoading(false);
    } catch (e) {
      print(e);
      Get.back();
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<void> updateLocation(LatLng latlng) async {
    selectedLocation.value = latlng;
    flutterMapController.move(latlng, 17);
  }

  getSearch(String filter) async {
    try {
      isoptionLoading.value = true;
      searchItem.value = await MapProvider().get_option_place(filter);
      isoptionLoading.value = false;
    } catch (e) {
      isoptionLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
      return [];
    }
  }

  pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
