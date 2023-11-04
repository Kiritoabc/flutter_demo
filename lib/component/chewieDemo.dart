import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:my_app_1/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Chewie 的案例
class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}



class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;
  int currPlayIndex = 0; // 当前播放的index

  String myIp = "http://172.24.240.1";

  // Dio 发送请求
  final dio = new Dio();

  // 接受Dio的数据
  List myListData = [];

  //
  void SearchAllParentVideoList() async {
    Response response;
    response = await dio.post('http://172.24.240.1:8888/teachingVideo/getTeachingParentVideoList');
    print(response.data['data']['list']);
    setState(() {
      myListData =
          response.data['data']['list'];
    });
    print(myListData);
  }
  //{
  // code: 0,
  // data: {
  // list: [{videoName: 1, videoIconUrl: /test/12.jpg, number: 3, content: 测试1, ID: 1}], total: 1},
  // msg: 获取成功
  // }

  @override
  void initState() {
    print("-------------------------------");
  // 发送请求
  SearchAllParentVideoList();
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // 集数展示
  // lib/res/listData.dart
  List listData = [
    {
      "title": 'Candy Shop',
      "author": 'Mohamed Chahin',
      "imageUrl": 'https://www.itying.com/images/flutter/1.png',
      "videoUrl":'http://172.24.240.1:9001/test/测试.mp4',
    },
    {
      "title": 'Childhood',
      "author": 'Google',
      "imageUrl": 'https://www.itying.com/images/flutter/2.png',
      "videoUrl":'https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4',
    },
    {
      "title": 'Alibaba Shop',
      "author": 'Alibaba',
      "imageUrl": 'https://www.itying.com/images/flutter/3.png',
      "videoUrl":'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    },
    {
      "title": 'Candy Shop',
      "author": 'Mohamed Chahin',
      "imageUrl": 'https://www.itying.com/images/flutter/4.png',
      "videoUrl":'http://172.24.240.1:9001/test/测试.mp4',
    },
    {
      "title": 'Tornado',
      "author": 'Mohamed Chahin',
      "imageUrl": 'https://www.itying.com/images/flutter/5.png',
      "videoUrl":'https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4',
    },
    {
      "title": 'Undo',
      "author": 'Mohamed Chahin',
      "imageUrl": 'https://www.itying.com/images/flutter/6.png',
      "videoUrl":'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    },
    {
      "title": 'white-dragon',
      "author": 'Mohamed Chahin',
      "imageUrl": 'https://www.itying.com/images/flutter/7.png',
      "videoUrl":'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    }
  ];

  // 初始化播放器
  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(listData[currPlayIndex]['videoUrl']));
    _videoPlayerController2 =
        VideoPlayerController.networkUrl(Uri.parse(listData[currPlayIndex]['videoUrl']));
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  // 修改集数函数
  Future<void> _updateCurrPlayIndex(index ) async{
    setState(() {
      currPlayIndex = index;
      print(listData[index]['videoUrl']);
    });
    // 重新初始化播放器
    await initializePlayer();
  }


  // 创建 _chewieController实例
  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
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
      // subtitle: Subtitles(subtitles),
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



  Widget _getListData(context,index){
    return Container(
      // 子元素
      child:Column(
        // 子元素
        children: <Widget>[
          // 图片
          InkWell(
            child: Image.network(
              listData[index]['imageUrl'],
              fit: BoxFit.cover,
            ),
            onTap: (){
              print("更换视频");
              _updateCurrPlayIndex(index);
            },
          ),
          // 图片与文字的间隔使用
          SizedBox(height:10),
          // 文字
          Text(
              listData[index]['title'],
              textAlign:TextAlign.center,
              style:TextStyle(fontSize: 18)
          ),
        ],
      ),
      // 装饰
      decoration: BoxDecoration(
        // 边框
          border:Border.all(
            // 颜色
              color:Color.fromRGBO(233, 233, 233, 0.8),
              // 边框宽度
              width:1.0
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: AppTheme.dark.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
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
            Expanded(
              flex: 1,
              child: Center(
                child: _chewieController != null &&
                    _chewieController!
                        .videoPlayerController.value.isInitialized
                    ? Chewie(
                  controller: _chewieController!,
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Loading'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200, // 根据需要设置高度
              child: GridView.builder(
                // 定义网格相关样式
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // 定义列
                    crossAxisCount: 2,
                    // 横向间隙
                    mainAxisSpacing: 10.0,
                    // 纵向间隙
                    crossAxisSpacing: 10.0,
                  ),
                  // 数据数量
                  itemCount: listData.length,
                  // 所有数据
                  itemBuilder: _getListData
              ),
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