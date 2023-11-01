

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
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
      "http://192.168.128.1:9001/test/测试.mp4",
      autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: FijkView(player: player),
      );
  }

}