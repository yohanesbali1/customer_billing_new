import 'dart:async';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

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
