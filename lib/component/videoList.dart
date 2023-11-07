import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/component/videoPlayer.dart';
import '../utils/config.dart';
import '../utils/dio_util.dart';


class PageViewExampleApp extends StatefulWidget {
  const PageViewExampleApp({super.key});

  @override
  State<StatefulWidget> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExampleApp> {

  String myIp = Config.myIp;

  String minioPort = Config.minioPort;

  String goBackend = Config.goBackend;

  final myListData = [];
  int total = 0;
  // 数据
  //  {
  //    list:[
  //        {ID: 1, CreatedAt: 2023-11-04T14:12:48.244+08:00, UpdatedAt: 2023-11-04T14:12:48.244+08:00, videoName: amusement-测试1, videoUrl: /test/amusement-测试12023-09-26 14-08-23.mp4, videoIconUrl: /test/amusement-测试12fe55140eae149c08b4a89779c34998f.jpg, type: 1, content: amusement-测试1},
  //        {ID: 2, CreatedAt: 2023-11-04T14:15:20.284+08:00, UpdatedAt: 2023-11-04T14:15:20.284+08:00, videoName: amusement-测试2, videoUrl: /test/amusement-测试22023-10-31 20-46-37.mp4, videoIconUrl: /test/amusement-测试2}XMF_AT$VVVU7E%AJ11YL_D.jpg, type: 1, content: amusement-测试2}
  //      ],
  //    total: 2
  //  }

  // 发送请求
  Future<void> GetAmusementVideo() async {
    Response response;
    HttpUtils.init();
    response = await HttpUtils.get("/amusement/get");
    print(response.data['data']);
    setState(() {
      myListData.addAll(response.data['data']['list']);
      total = response.data['data']['total'];
      print("==================================$total===============================");
    });
  }

  @override
  void initState() {
    super.initState();
    GetAmusementVideo();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    List<Widget> centers = List.generate(myListData.length, (index) => Center(
      child: VideoPlayerScreen(videoUrl: myIp+minioPort+myListData[index]['videoUrl'],),
    ));

    return PageView(
      scrollDirection: Axis.vertical,
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: <Widget>[
        ...centers
      ],
    );
  }

}
