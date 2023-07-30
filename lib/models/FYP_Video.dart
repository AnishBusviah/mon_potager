import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FYP_Video extends StatefulWidget {
  FYP_Video(this.vidLink, {Key? key}) : super(key: key);
  String vidLink;
  @override
  // ignore: library_private_types_in_public_api
  _FYP_VideoState createState() => _FYP_VideoState();
}

class _FYP_VideoState extends State<FYP_Video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        widget.vidLink) // Replace with your actual video file path
      ..initialize().then((_) {
        setState(() {
          _controller.value.isPlaying? _controller.play() : _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Container(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );

    //   Scaffold(
    //   extendBodyBehindAppBar: true,
    //   body: Center(
    //     child: _controller.value.isInitialized
    //         ? AspectRatio(
    //       aspectRatio: _controller.value.aspectRatio,
    //       child: VideoPlayer(_controller),
    //     )
    //         : const CircularProgressIndicator(),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         _controller.value.isPlaying
    //             ? _controller.pause()
    //             : _controller.play();
    //       });
    //     },
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
  }
}
