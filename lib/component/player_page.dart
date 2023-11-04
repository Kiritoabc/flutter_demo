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


  @override
  void initState() {
    super.initState();
    print("bilibili视频播放器");
    player.setDataSource(
      // "http://172.24.240.1:9001/test/测试.mp4",
      'http://172.24.240.1:9001/test/amusement-测试12023-09-26 14-08-23.mp4',
      autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: FijkView(player: player),
      );
  }

}