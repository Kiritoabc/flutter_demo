import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomFijkPanel({
    required this.player,
    required this.buildContext,
    required this.viewSize,
    required this.texturePos,
  });

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {

  FijkPlayer get player => widget.player;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    widget.player.addListener(_playerValueChanged);
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    bool playing = (value.state == FijkState.started);
    if (playing != _playing) {
      setState(() {
        _playing = playing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: IconButton(
          icon: Icon(
            _playing ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            _playing ? widget.player.pause() : widget.player.start();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.removeListener(_playerValueChanged);
  }
}


class FijkPlayerExample extends StatefulWidget {
  @override
  _FijkPlayerExampleState createState() => _FijkPlayerExampleState();
}

class _FijkPlayerExampleState extends State<FijkPlayerExample> {
  final FijkPlayer player = FijkPlayer(); // 创建 FijkPlayer 实例

  @override
  void initState() {
    super.initState();
    player.setDataSource(
      "http://192.168.128.1:9001/test/测试.mp4",
      autoPlay: true); // 初始化 FijkPlayer
  }

  @override
  void dispose() {
    player.release(); // 释放 FijkPlayer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 在这里设置你的视图大小和纹理位置
    final viewSize = Size(300, 200);
    final texturePos = Rect.fromLTRB(10, 10, 310, 210);

    return CustomFijkPanel(
      player: player,
      buildContext: context,
      viewSize: viewSize,
      texturePos: texturePos,
    );
  }
}