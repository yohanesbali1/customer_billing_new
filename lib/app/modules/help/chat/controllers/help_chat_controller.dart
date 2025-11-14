import 'dart:io';

import 'package:vigo_customer_billing/app/core/helpers/helpers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/repositories/chat_repository.dart';

class HelpChatController extends GetxController {
  final ChatRepository repository;
  HelpChatController({required this.repository});

  var isLoading = true.obs;
  var data = [].obs;
  var firebase_data = [].obs;
  var id = ''.obs;
  var page = 1.obs;
  var message = TextEditingController().obs;
  final formkey = GlobalKey<FormState>();
  OverlayEntry? overlayEntry = null;
  final firebaseMessage = FirebaseMessaging.instance;
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final picker = ImagePicker();
  var image = Rxn<File>();
  XFile? videoFile;

  var chat_data = <ChatModel>[].obs;
  var page_index = 0.obs;
  var isLoadMore = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var perPage = 10.obs;

  void onInit() {
    super.onInit();
    id.value = Get.parameters['id'] ?? '';
  }

  void onReady() {
    super.onReady();

    scrollController.addListener(() => onScroll());
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data != null &&
          message.data['type'] == "ticket_${id.value}") {
        getData();
      }
    });
  }

  clear_form() {
    message.value.clear();
  }

  dynamic onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadMore.value) {
      if (currentPage.value < lastPage.value) {
        getData(loadMore: true);
      }
    }
  }

  // getData() async {
  //   try {
  //     isLoading.value = true;
  //     data.value = await repository.getChatData(id: id.value, page: page.value);
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (scrollController.hasClients) {
  //         scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //       }
  //     });
  //     isLoading.value = false;
  //   } catch (e) {
  //     isLoading.value = false;
  //     String errorMessage = e is String
  //         ? e
  //         : 'Maaf ada kesalahan, silahkan coba lagi';
  //     Helper().AlertGetX(null, errorMessage);
  //   }
  // }

  Future<void> getData({bool loadMore = false}) async {
    try {
      if (loadMore && currentPage.value >= lastPage.value) return;
      // isLoadMore(true);
      if (loadMore) {
        isLoadMore.value = true;
      } else {
        isLoading.value = true;
      }

      int _currentPage;
      _currentPage = loadMore ? currentPage.value + 1 : 1;
      final response = await repository.getChatData(
        page: _currentPage,
        perPage: perPage.value,
      );
      if (loadMore) {
        chat_data.addAll(response.data);
      } else {
        chat_data.assignAll(response.data);
      }
      currentPage.value = loadMore ? _currentPage : 1;
      lastPage.value = response.meta?.lastPage ?? 1;
    } catch (e) {
      Helper().AlertSnackBar();
    } finally {
      isLoading(false);
      isLoadMore(false);
    }
  }

  String? validator_input(value) {
    return value!.isEmpty ? '' : null;
  }

  submit_data({bool file = false}) async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var payload;
      if (file) {
        payload = {"file": image.value};
      } else {
        payload = {'message': message.value.text};
      }
      // await HelperProvider().submitChat(payload, id);
      // await HelperProvider().submitFireStoreChat(result, id.value);
      await getData();
      Get.back();
      // await Helper().AlertGetX('success', null);
      clear_form();
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

  delete_data(payload) async {
    try {
      isLoading(true);
      Helper().AlertGetX('loading', null);
      var items = {"chat_id": payload};
      // await HelperProvider().deleteChat(items);
      await getData();
      Get.back();
      // await Helper().AlertGetX('success', null);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
    }
  }

  Future<void> handleRefresh() async {
    // Get current scroll offset before loading new data
    double beforeRefreshOffset = scrollController.offset;

    // Simulate data fetching
    // await controller.getData(); // This should append older data at the top

    // Rebuild the list
    // setState(() {
    //   _buildItems();
    // });

    // // Delay to wait for the list to rebuild and calculate the new content size
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (_scrollController.hasClients) {
    //     // Get the new scroll extent difference
    //     double newOffset =
    //         _scrollController.position.maxScrollExtent - beforeRefreshOffset;
    //     _scrollController.jumpTo(
    //         _scrollController.position.maxScrollExtent - newOffset);
    //   }
    // });
  }

  // void cancelVideo() {
  //   videoPlayerController?.pause();
  //   videoFile = null;
  //   videoPlayerController = null;
  //   update();
  // }

  pickMedia({
    required bool pickImage,
    ImageSource source = ImageSource.gallery,
  }) async {
    final pickedFile;
    if (pickImage) {
      pickedFile = await _picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );
    } else {
      pickedFile = await _picker.pickVideo(
        source: source,
        preferredCameraDevice: CameraDevice.rear,
      );
    }

    image.value = File(pickedFile.path);
    submit_data(file: true);
  }
}
