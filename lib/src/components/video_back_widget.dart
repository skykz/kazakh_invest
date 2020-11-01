import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackgoundWidget extends StatefulWidget {
  const VideoBackgoundWidget({Key key}) : super(key: key);

  @override
  _VideoBackgoundWidgetState createState() => _VideoBackgoundWidgetState();
}

class _VideoBackgoundWidgetState extends State<VideoBackgoundWidget> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    // ..initialize().then((_) {
    //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   setState(() {});
    // });

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VideoPlayer(_controller),
    );
  }
}
