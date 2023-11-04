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
                            MaterialPageRoute(builder: (context) => ChewieDemo(ParentId: myListData[index]['ID'])),
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