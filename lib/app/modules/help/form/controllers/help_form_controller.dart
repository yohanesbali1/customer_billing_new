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
  final HelpDetailController detailController =
      Get.find<HelpDetailController>();
  final HelpController helpController = Get.find<HelpController>();
  HelpFormController({required this.repository, required this.mapsRepository});

  final formkey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isoptionLoading = false.obs;
  var id = ''.obs;

  Rxn<DisorderCategory?> type_topic_value = Rxn<DisorderCategory?>();
  int type_topic_select = 0;

  var titleController = TextEditingController();
  final Rxn<String> titleError = Rxn<String>();
  var unitController = TextEditingController();
  final Rxn<String> unitError = Rxn<String>();
  var addressController = TextEditingController();
  final Rxn<String> addressError = Rxn<String>();
  var phoneController = TextEditingController();
  final Rxn<String> phoneError = Rxn<String>();
  var typeTopicController = TextEditingController();
  final Rxn<String> typeTopicError = Rxn<String>();
  var complaintController = TextEditingController();
  final Rxn<String> complaintError = Rxn<String>();
  var requestDateController = TextEditingController();
  final Rxn<String> requestDateError = Rxn<String>();
  var descriptionController = TextEditingController();
  final Rxn<String> descriptionError = Rxn<String>();
  var mapsController = TextEditingController();

  var type_topic_data = <DisorderCategory>[].obs;

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
    id.value = Get.parameters['id'] ?? '';
    debounce(search, (String value) async {
      await Future.delayed(Duration(milliseconds: 300)); // Optional delay
      getSearch(value);
    }, time: Duration(milliseconds: 500));
  }

  @override
  void onReady() {
    super.onReady();
    Future.microtask(() => getData());
  }

  @override
  void onClose() {
    flutterMapController.dispose();
    super.onClose();
  }

  void clear_form() {
    addressController.clear();
    phoneController.clear();
    descriptionController.clear();
    mapsController.clear();
    typeTopicController.clear();
    image.value = null;
  }

  bool validatePhone() {
    final val = phoneController.text.trim();
    if (val.isEmpty) {
      phoneError.value = 'Telepon harus diisi';
      return false;
    }
    if (!RegExp(r'^\d+$').hasMatch(val)) {
      phoneError.value = 'Telepon harus angka';
      return false;
    }
    phoneError.value = null;
    return true;
  }

  bool validateUnit() {
    final val = unitController.text.trim();
    if (val.isEmpty) {
      unitError.value = 'Unit harus diisi';
      return false;
    }
    unitError.value = null;
    return true;
  }

  bool validateTypeTopic() {
    final val = typeTopicController.text.trim();
    if (val.isEmpty) {
      typeTopicError.value = 'Unit harus diisi';
      return false;
    }
    typeTopicError.value = null;
    return true;
  }

  bool validateAddress() {
    final val = addressController.text.trim();
    if (val.isEmpty) {
      addressError.value = 'Alamat harus diisi';
      return false;
    }
    addressError.value = null;
    return true;
  }

  bool validateComplaint() {
    final val = complaintController.text.trim();
    if (val.isEmpty) {
      complaintError.value = 'Komplain harus diisi';
      return false;
    }
    complaintError.value = null;
    return true;
  }

  bool validateDescription() {
    final val = descriptionController.text.trim();
    if (val.isEmpty) {
      descriptionError.value = 'Deskripsi harus diisi';
      return false;
    }
    descriptionError.value = null;
    return true;
  }

  bool validateRequestDate() {
    final val = requestDateController.text.trim();
    if (val.isEmpty) {
      requestDateError.value = 'Tanggal request harus diisi';
      return false;
    }
    try {
      DateTime.parse(val);
      requestDateError.value = null;
      return true;
    } catch (_) {
      requestDateError.value = 'Tanggal request harus yyyy-mm-dd';
      return false;
    }
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
      isLoading.value = true;
      Helper().AlertGetX(type: 'loading');
      await getTypeData();
      if (id.value != '') {
        final HelpModel data = detailController.reportData.value!;
        addressController.text = data.address!;
        phoneController.text = data.noTelp!;
        descriptionController.text = data.description!;
        typeTopicController.text = data.disorderCategory!.type!;
        type_topic_value.value = data.disorderCategory!;
        var parts = data.maps!.split(',');
        if (parts.length >= 2) {
          mapsController.text = data.maps!;
          await updateLocation(
            LatLng(double.parse(parts[0]), double.parse(parts[1])),
          );
        }
      } else {
        await getCurrentLocation();
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    } finally {
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  Future<dynamic> submit_data() async {
    try {
      isLoading(true);
      Helper().AlertGetX(type: 'loading');
      var form = {
        'phone': phoneController.text,
        'address': addressController.text,
        'maps':
            "${selectedLocation.value!.latitude},${selectedLocation.value!.longitude}",
        'type_topic_id': type_topic_value.value!.id.toString(),
        'description': descriptionController.text,
      };

      await repository.submitHelp(
        id.value,
        form,
        image.value, // kirim File di sini
      );
      if (id.value == '') {
        await helpController.getData();
      } else {
        await detailController.getData(id.value);
      }
      ;
      Get.back();
      await Helper().AlertGetX(
        type: 'success',
        message: "Data berhasil disimpan",
      );
      Get.back();
      isLoading(false);
    } catch (e) {
      Get.back();
      isLoading(false);
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }

  Future<dynamic> select_type_data() async {
    try {
      type_topic_value.value = type_topic_data.value[type_topic_select];
      typeTopicController.text = type_topic_value.value!.name.toString();
    } catch (e) {
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
    }
  }

  Future<dynamic> getCurrentLocation() async {
    try {
      isLoading(true);
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          Helper().AlertGetX(message: 'Aktifkan akses lokasi di pengaturan');
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      await updateLocation(LatLng(position.latitude, position.longitude));
      isLoading(false);
    } catch (e) {
      Get.back();
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(message: errorMessage);
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
      Helper().AlertGetX(message: errorMessage);
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
