import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/component/videoInfo.dart';

import 'package:my_app_1/component/chewieDemo.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _PageHomeState();

}


class _PageHomeState extends State<PageHome> {

  final TextEditingController _searchController = TextEditingController();

  String myIp = "http://172.24.240.1";

  String minioPort = ":9001";

  String goBackend = ":8888";

  // Dio 发送请求
  final dio = new Dio();

  // 接受Dio的数据
  // {
  //    videoName: 1,
  //    videoIconUrl: /test/12.jpg,
  //    number: 3,
  //    content: 测试1,
  //    ID: 1
  // }
  List myListData = [];
  int total = 0;
  //
  void SearchAllParentVideoList() async {
    Response response;
    response = await dio.post('$myIp$goBackend/teachingVideo/getTeachingParentVideoList');
    print(response.data['data']);
    setState(() {
      myListData =
      response.data['data']['list'];
      total =
          response.data['data']['total'];
      print("当前数据 ${total}");
      print(myListData[0]['videoName']);
    });
  }

  @override
  void initState(){
    super.initState();
    // 查询所有数据
    SearchAllParentVideoList();
  }



  @override
  Widget build(BuildContext context) {

    // 跳转记录
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    // 数据准备
    List<VideoInfo> videoInfos = [
      VideoInfo(videoName: 'Video 1',
        videoIconUrl: 'https://ts1.cn.mm.bing.net/th/id/R-C.2a5cb21e95d37dc74ae142ed6201e92c?rik=n3v82FY0aF70Vg&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f85%2f9585_7.jpg&ehk=M6esrkq9sRZTGR5iduLvhWjLYTHY2qAu6M02yrPqVdc%3d&risl=&pid=ImgRaw&r=0',
        number: 2,
      content: "测试1",),
      VideoInfo(videoName: 'Video 2', videoIconUrl: 'https://pic2.zhimg.com/v2-febc9228d18886a29c68a66536279dfb_r.jpg?source=1940ef5c',number: 3,content: "测试2",),
      VideoInfo(videoName: 'Video 3', videoIconUrl: 'https://tse3-mm.cn.bing.net/th/id/OIP-C.z30umoh6fUAJ-m1musuZNwHaEo?pid=ImgDet&rs=1',number: 4,content: "测试3",),
      VideoInfo(videoName: 'Video 4', videoIconUrl: 'https://tse4-mm.cn.bing.net/th/id/OIP-C.igshDvZF0ZmKg6z9B2q8sQHaLH?pid=ImgDet&rs=1',number: 4,content: "测试4",),
      VideoInfo(videoName: 'Video 5', videoIconUrl: 'https://pic1.zhimg.com/v2-d36ecbf8ea95f6b609c995165aad3975_r.jpg?source=1940ef5c',number: 4,content: "测试5",),
      VideoInfo(videoName: 'Video 6', videoIconUrl: 'https://ts1.cn.mm.bing.net/th/id/R-C.723adea0d010c5cc8ab3f4dc39c32df7?rik=FcF2o3BM%2fte5fg&riu=http%3a%2f%2fss605.com%2fuploadfiles%2fimage%2f20201225%2f20201225162327312731.jpg&ehk=Rjq4BD89O5Th1G6ycl6xGhSTiCA5mOZr4DaR5I1bdik%3d&risl=&pid=ImgRaw&r=0',number: 4,content: "测试6",),
    ];

    // 返回
    return Column(
        children: [
          Stack(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: '请输入搜索关键词',
                ),
              ),
              Positioned(
                right: 4,
                bottom: 2,
                child: ElevatedButton(
                  onPressed: () {
                    // 在这里处理搜索逻辑
                    String searchKeyword = _searchController.text;
                    // 在这里处理搜索逻辑，使用searchKeyword作为搜索关键词
                    print('搜索关键词： ${searchKeyword}');
                  },
                  child: const Text('搜索'),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: total,
                itemBuilder: (context,index) {
                  return SizedBox(
                        width: 800, height: 120,
                        child: InkWell(onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChewieDemo()),
                          );
                          // 在这里添加你的点击事件处理逻辑
                            print('视频信息 $index 被点击');
                          },
                        child: VideoInfo(
                          videoIconUrl: myIp + minioPort + myListData[index]['videoIconUrl'],
                          videoName: myListData[index]['videoName'],
                          number: myListData[index]['number'],
                          content: myListData[index]['content']
                          )
                        )
                  );
                }
            ),
          ),
          ],
    );
  }
}