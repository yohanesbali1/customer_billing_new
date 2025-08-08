import 'package:customer_billing/app/modules/help/help_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:customer_billing/app/modules/help/help_chat_controller.dart';

enum MediaType { image, video }

class FullscreenMediaWidget extends StatelessWidget {
  final String url;
  final MediaType mediaType;

  const FullscreenMediaWidget({
    Key? key,
    required this.url,
    required this.mediaType,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (mediaType == MediaType.video) {
      final controller = Get.isRegistered<ChatVideoController>(tag: url)
          ? Get.find<ChatVideoController>(tag: url)
          : Get.put(ChatVideoController(url), tag: url);

      return WillPopScope(
        onWillPop: () async {
          await controller.videoController.pause();
          Get.delete<ChatVideoController>(tag: url);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(() {
              if (!controller.isInitialized.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final videoController = controller.videoController;

              return AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: controller.toggleControlsVisibility,
                      child: VideoPlayer(videoController),
                    ),

                    // Play button overlay saat pause
                    if (!controller.isPlaying.value)
                      GestureDetector(
                        onTap: controller.togglePlayPause,
                        child: Center(
                          child: Container(
                            color: Colors.black38,
                            child: const Icon(Icons.play_arrow,
                                color: Colors.white, size: 60),
                          ),
                        ),
                      ),

                    // Kontrol slider & tombol muncul sesuai showControls
                    Obx(() => controller.showControls.value
                        ? Container(
                            color: Colors.black38,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Slider(
                                  min: 0,
                                  max: videoController.value.duration.inSeconds
                                      .toDouble(),
                                  value: controller
                                      .currentPosition.value.inSeconds
                                      .clamp(
                                          0,
                                          videoController
                                              .value.duration.inSeconds)
                                      .toDouble(),
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.white30,
                                  onChanged: (value) {
                                    videoController.seekTo(
                                        Duration(seconds: value.toInt()));
                                  },
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        controller.isPlaying.value
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      onPressed: controller.togglePlayPause,
                                    ),
                                    Text(
                                      '${_formatDuration(controller.currentPosition.value)} / ${_formatDuration(videoController.value.duration)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink()),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    } else if (mediaType == MediaType.image) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 1.0,
                  maxScale: 5.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
