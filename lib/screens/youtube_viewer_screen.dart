import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeViewerScreen extends ConsumerStatefulWidget {
  const YoutubeViewerScreen({
    super.key,
    required this.videoLink,
  });

  final String videoLink;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _YoutubeViewerScreenState();
}

class _YoutubeViewerScreenState extends ConsumerState<YoutubeViewerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoLink,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          child: YoutubePlayer(controller: _controller),
        ),
      ),
    );
  }
}
