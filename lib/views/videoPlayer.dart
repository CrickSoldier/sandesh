import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPLayer extends StatefulWidget {
  final String url;

  VideoPLayer({@required this.url});

  @override
  _VideoPLayerState createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<VideoPLayer> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.NETWORK, widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }
}
// VideoPlayerController _controller;

// @override
// void initState() {
//   super.initState();
//   _controller = VideoPlayerController.network(widget.url)
//     ..initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//       setState(() {});
//     });
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: _controller.value.initialized
//           ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             )
//           : Container(),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         setState(() {
//           _controller.value.isPlaying
//               ? _controller.pause()
//               : _controller.play();
//         });
//       },
//       child: Icon(
//         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//       ),
//     ),
//   );
// }

// @override
// void dispose() {
//   super.dispose();
//   _controller.dispose();
// }

// BetterPlayerController _betterPlayerController;
//       BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//           BetterPlayerDataSourceType.NETWORK, documentSnapshot.data['video']);
//       _betterPlayerController = BetterPlayerController(
//           BetterPlayerConfiguration(),
//           betterPlayerDataSource: betterPlayerDataSource);

//       @override
//       void initState() {
//         super.initState();
//         BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//             BetterPlayerDataSourceType.NETWORK, documentSnapshot.data['video']);
//         _betterPlayerController = BetterPlayerController(
//             BetterPlayerConfiguration(),
//             betterPlayerDataSource: betterPlayerDataSource);
//       }

//       return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => VideoPLayer(
//                         url: documentSnapshot.data['video'],
//                       )));
//         },
//         child: BetterPlayer(
//           controller: _betterPlayerController,
//         ),
//       );
//       @override
//       void dispose() {
//         super.dispose();
//         _betterPlayerController.dispose();
//       }
