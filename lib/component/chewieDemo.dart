import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/utils/dio_util.dart';
import 'package:video_player/video_player.dart';

import '../utils/config.dart';
import '../video_details/models.dart';

// Chewie 的案例
class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo', required this.ParentId, required this.movie,
  }) : super(key: key);

  final String title;
  final int ParentId;
  final Movie movie;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;
  int currPlayIndex = 0; // 当前播放的index

  String myIp = Config.myIp;

  String minioPort = Config.minioPort;

  String goBackend = Config.goBackend;

  // Dio 发送请求
  final dio = new Dio();
  // 接受Dio的数据
  //{
  //   list: [
  //      {ID: 1, CreatedAt: 2023-11-02T13:35:44.308+08:00, UpdatedAt: 2023-11-02T13:35:44.308+08:00, videoName: 1, videoUrl: /test/1测试.mp4, videoIcon: /test/12.jpg, group: 0, type: 0, number: 3, episode: 1, parentId: 1, content: 测试1},
  //      {ID: 2, CreatedAt: 2023-11-02T13:38:04.536+08:00, UpdatedAt: 2023-11-02T13:38:04.536+08:00, videoName: 2, videoUrl: /test/2测试.mp4, videoIcon: /test/25c23d52f880511ebb6edd017c2d2eca2.jpg, group: 0, type: 0, number: 3, episode: 2, parentId: 1, content: 测试1},
  //      {ID: 3, CreatedAt: 2023-11-02T13:40:53.378+08:00, UpdatedAt: 2023-11-02T13:40:53.378+08:00, videoName: 3, videoUrl: /test/3测试.mp4, videoIcon: /test/31.jpg, group: 0, type: 0, number: 3, episode: 3, parentId: 1, content: 测试1}
  //  ],
  //  total: 3
  // }
  List myListData = [];
  // 初始化数据
  void SearchAllSonVideoList() async {
    Response response;
    // 数据准备
    var formData = FormData.fromMap({
      'ParentId': widget.ParentId,
    });
    HttpUtils.init();
    response = await HttpUtils.post('/teachingVideo/getTeachingSonVideoList',data: formData);
    setState(() {
      myListData = response.data['data']['list'];
      print(myListData);
    });
    initializePlayer();
  }

  @override
  void initState() {
    print("-------------------------------");
  // 发送请求
    super.initState();
    SearchAllSonVideoList();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // 初始化播放器
  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(myIp+minioPort+myListData[currPlayIndex]['videoUrl']));
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  // 修改集数函数
  Future<void> _updateCurrPlayIndex(index ) async{
    setState(() {
      currPlayIndex = index;
      print(myIp+minioPort+myListData[index]['videoUrl']);
    });
    // 重新初始化播放器
    await initializePlayer();
  }

  // 创建 _chewieController实例
  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 16/9,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
      bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
          text: subtitle,
        )
            : Text(
          subtitle.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  // 估计不需要了
  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex += 1;
    await initializePlayer();
  }
  Widget _buildPhoto(BuildContext context, int index) {
    var photo = widget.movie.photoUrls[index];
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          child: Stack(
            children: [
              Image.network(
                photo,
                width: 160.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.play_circle),
                  onPressed: () {
                    print("更换视频");
                    _updateCurrPlayIndex(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
            style: const TextStyle(
              color: Colors.black87, // 设置字体颜色
              fontSize: 20,   // 设置字体大小
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            //这是图标长按会出现的提示信息，返回按钮这么常用，应该不需要吧
            //tooltip: '返回上一页',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              //_nextPage(-1);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              width: 353,
              height: 220,
              child: _chewieController != null &&
                  _chewieController!
                      .videoPlayerController.value.isInitialized
                  ? Chewie(controller: _chewieController!,)
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading'),
                ],
              ),
            ),
            const SizedBox(
              height:30,
              child: Text(
                  "选集",
                  textAlign:TextAlign.left,
                  style:TextStyle(fontSize: 18)
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Episode',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox.fromSize(
                size: const Size.fromHeight(100.0),
                child: ListView.builder(
                  itemCount: widget.movie.photoUrls.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                  itemBuilder: _buildPhoto,
                ),
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}

// 滑动器
class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;
  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
          widget.onSave(delay);
          setState(() {
            saved = true;
          });
        },
      ),
    );
  }
}