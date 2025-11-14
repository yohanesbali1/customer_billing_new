import 'package:flutter/material.dart';

class ChatVideoWidget extends StatelessWidget {
  final String videoUrl;
  final double aspectRatio;

  const ChatVideoWidget({
    required this.videoUrl,
    this.aspectRatio = 1.0,
    Key? key,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatVideoController(videoUrl), tag: videoUrl);

    return Obx(() {
      if (!controller.isInitialized.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final videoController = controller.videoController;
      final position = controller.currentPosition.value;
      final duration = videoController.value.duration;

      return AspectRatio(
        aspectRatio: videoController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: controller.togglePlayPause,
              child: VideoPlayer(videoController),
            ),

            // Center play icon
            if (!controller.isPlaying.value)
              GestureDetector(
                onTap: controller.togglePlayPause,
                child: Center(
                  child: Container(
                    color: Colors.black38,
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),

            // Bottom controls
            Container(
              color: Colors.black38,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress bar
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds
                        .clamp(0, duration.inSeconds)
                        .toDouble(),
                    activeColor: Colors.red,
                    inactiveColor: Colors.white30,
                    onChanged: (value) {
                      videoController.seekTo(Duration(seconds: value.toInt()));
                    },
                  ),
                  // Play + Time + Fullscreen
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
                        '${_formatDuration(position)} / ${_formatDuration(duration)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FullscreenMediaWidget(
                                url: videoUrl,
                                mediaType: MediaType.video,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
