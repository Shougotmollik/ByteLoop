import 'package:byteloop/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShowAsset extends StatefulWidget {
  final String asset = Get.arguments;

  ShowAsset({super.key});

  @override
  State<ShowAsset> createState() => _ShowAssetState();
}

class _ShowAssetState extends State<ShowAsset> {
  VideoPlayerController? _videoController;
  bool isVideo = false;

  @override
  void initState() {
    super.initState();

    isVideo =
        widget.asset.endsWith('.mp4') ||
        widget.asset.endsWith('.mov') ||
        widget.asset.endsWith('.webm');

    if (isVideo) {
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(getS3Url(widget.asset)))
            ..initialize().then((_) {
              setState(() {}); // refresh after initialization
            });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: isVideo
            ? _videoController != null && _videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          VideoPlayer(_videoController!),
                          VideoProgressIndicator(
                            _videoController!,
                            allowScrubbing: true,
                          ),
                          IconButton(
                            icon: Icon(
                              _videoController!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                _videoController!.value.isPlaying
                                    ? _videoController!.pause()
                                    : _videoController!.play();
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator()
            : Image.network(getS3Url(widget.asset), fit: BoxFit.contain),
      ),
    );
  }
}
