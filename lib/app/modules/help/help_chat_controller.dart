import 'dart:async';
import 'dart:io';

import 'package:customer_billing/app/core/helpers/helpers.dart';
import 'package:customer_billing/app/data/providers/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HelpChatController extends GetxController {
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

  void onInit() {
    super.onInit();
    id.value = Get.parameters['id'] ?? '';
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

  getData() async {
    try {
      isLoading.value = true;
      data.value = await HelperProvider().get_chat(id.value, page.value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      String errorMessage = e is String
          ? e
          : 'Maaf ada kesalahan, silahkan coba lagi';
      Helper().AlertGetX(null, errorMessage);
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
      await HelperProvider().submitChat(payload, id);
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
      await HelperProvider().deleteChat(items);
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

class ChatVideoController extends GetxController {
  late VideoPlayerController videoController;

  var isPlaying = false.obs;
  var isInitialized = false.obs;
  var currentPosition = Duration.zero.obs;

  var showControls = true.obs;

  Timer? _hideTimer;

  ChatVideoController(String url) {
    videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        isInitialized.value = true;
        videoController.addListener(_videoListener);
        videoController.setLooping(false);
      });
  }

  void _videoListener() {
    if (videoController.value.isInitialized) {
      currentPosition.value = videoController.value.position;

      if (videoController.value.position >= videoController.value.duration) {
        if (videoController.value.isPlaying) {
          videoController.pause();
        }
        isPlaying.value = false;
        showControls.value = true;
        _hideTimer?.cancel();
      }
    }
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
      isPlaying.value = false;
      showControls.value = true;
      _hideTimer?.cancel();
    } else {
      if (videoController.value.position >= videoController.value.duration) {
        videoController.seekTo(Duration.zero).then((_) {
          videoController.play();
          isPlaying.value = true;
          _startHideTimer();
        });
      } else {
        videoController.play();
        isPlaying.value = true;
        _startHideTimer();
      }
    }
  }

  void toggleControlsVisibility() {
    showControls.value = !showControls.value;

    if (showControls.value && isPlaying.value) {
      _startHideTimer();
    } else {
      _hideTimer?.cancel();
    }
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (isPlaying.value) {
        showControls.value = false;
      }
    });
  }

  @override
  void onClose() {
    _hideTimer?.cancel();
    videoController.removeListener(_videoListener);
    videoController.pause();
    videoController.dispose();
    super.onClose();
  }
}
