import 'dart:io';

import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/help_repository.dart';
import 'package:vigo_customer_billing/app/data/repositories/maps_repository.dart';
import 'package:vigo_customer_billing/app/modules/help/controllers/help_controller.dart';
import 'package:vigo_customer_billing/app/modules/help/detail/controlllers/help_detail_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class HelpFormController extends GetxController {
  final HelpRepository repository;
  final MapsRepository mapsRepository;
  late final HelpDetailController detailController;
  HelpFormController({required this.repository, required this.mapsRepository});

  final formkey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isoptionLoading = false.obs;
  var id = ''.obs;

  Rxn<TypeTopic?> type_topic_value = Rxn<TypeTopic?>();
  int type_topic_select = 0;

  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var typeTopicController = TextEditingController();
  var descriptionController = TextEditingController();
  var mapsController = TextEditingController();

  var type_topic_data = <TypeTopic>[].obs;

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
    detailController = Get.find<HelpDetailController>();
    getData();
    getTypeData();
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
    addressController.clear();
    phoneController.clear();
    descriptionController.clear();
    mapsController.clear();
    typeTopicController.clear();
    image.value = null;
  }

  String? validator_input(value) {
    return value!.isEmpty ? 'Field ini harus diisi' : null;
  }

  Future<dynamic> getTypeData() async {
    try {
      isLoading.value = true;
      type_topic_data.value = await repository.getTypeHelp();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> getData() async {
    try {
      id.value = Get.parameters['id'] ?? '';
      isLoading.value = true;
      // if (id.value != '') {
      //   final HelpModelDetail data = detail_controller.reportData.value!;
      //   addressController.text = data.address!;
      //   phoneController.text = data.phone!;
      //   descriptionController.text = data.description!;
      //   typeTopicController.text = data.typeTopic!.type!;
      //   type_topic_value.value = data.typeTopic!;
      //   var parts = data.maps!.split(',');
      //   if (parts.length >= 2) {
      //     mapsController.text = data.maps!;
      //     await updateLocation(
      //       LatLng(double.parse(parts[0]), double.parse(parts[1])),
      //     );
      //   }
      // } else {
      //   await getCurrentLocation();
      // }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<dynamic> submit_data() async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var data = {
        "id": id.value,
        "form": {
          'phone': phoneController.text,
          'address': addressController.text,
          'maps':
              "${selectedLocation.value!.latitude},${selectedLocation.value!.longitude}",
          'type_topic_id': type_topic_value.value!.id.toString(),
          'description': descriptionController.value.text,
          'img': image.value,
        },
      };
      await repository.submitHelp(data);
      // if (id.value == '') {
      //   await repository.getHelpData();
      // } else {
      //   detail_controller.reportData.value = await HelperProvider()
      //       .showreportData(id.value);
      // }
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

  Future<dynamic> select_type_data() async {
    try {
      type_topic_value.value = type_topic_data.value[type_topic_select];
      typeTopicController.text = type_topic_value.value!.type.toString();
    } catch (e) {
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<dynamic> getCurrentLocation() async {
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
      Get.back();
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<dynamic> updateLocation(LatLng latlng) async {
    selectedLocation.value = latlng;
    flutterMapController.move(latlng, 17);
  }

  Future<dynamic> getSearch(String filter) async {
    try {
      isoptionLoading.value = true;
      searchItem.value = await mapsRepository.getMap(filter);
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

  Future<dynamic> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }
}
