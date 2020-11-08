import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreen extends StatefulWidget {
  final String videoLink;
  const VideoFullScreen({Key key, this.videoLink}) : super(key: key);

  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(widget.videoLink);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      showControls: true,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context)),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
