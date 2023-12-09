import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    Key? key,
    required this.videoUrl
  }) : super(key: key);


    final String videoUrl;

  @override
  State<StatefulWidget> createState() => _PlayerPage();
}


class _PlayerPage extends State<PlayerPage> {
  final FijkPlayer player = FijkPlayer();


  // todo： bilibili 视频播放器
  @override
  void initState() {
    super.initState();
    print("bilibili视频播放器");
    player.setDataSource(
        widget.videoUrl,
        autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: FijkView(player: player),
      );
  }

}