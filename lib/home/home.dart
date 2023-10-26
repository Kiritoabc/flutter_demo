import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/component/videoInfo.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _PageHomeState();

}


class _PageHomeState extends State<PageHome> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 数据准备
    List<VideoInfo> videoInfos = [
      const VideoInfo(videoTitle: 'Video 1',
        videoImageUrl: 'https://ts1.cn.mm.bing.net/th/id/R-C.2a5cb21e95d37dc74ae142ed6201e92c?rik=n3v82FY0aF70Vg&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f85%2f9585_7.jpg&ehk=M6esrkq9sRZTGR5iduLvhWjLYTHY2qAu6M02yrPqVdc%3d&risl=&pid=ImgRaw&r=0',
        videoCount: 2,
      videoContent: "测试1",),
      VideoInfo(videoTitle: 'Video 2', videoImageUrl: 'https://pic2.zhimg.com/v2-febc9228d18886a29c68a66536279dfb_r.jpg?source=1940ef5c',videoCount: 3,videoContent: "测试2",),
      VideoInfo(videoTitle: 'Video 3', videoImageUrl: 'https://tse3-mm.cn.bing.net/th/id/OIP-C.z30umoh6fUAJ-m1musuZNwHaEo?pid=ImgDet&rs=1',videoCount: 4,videoContent: "测试3",),
      VideoInfo(videoTitle: 'Video 4', videoImageUrl: 'https://tse4-mm.cn.bing.net/th/id/OIP-C.igshDvZF0ZmKg6z9B2q8sQHaLH?pid=ImgDet&rs=1',videoCount: 4,videoContent: "测试4",),
      VideoInfo(videoTitle: 'Video 5', videoImageUrl: 'https://pic1.zhimg.com/v2-d36ecbf8ea95f6b609c995165aad3975_r.jpg?source=1940ef5c',videoCount: 4,videoContent: "测试5",),
      VideoInfo(videoTitle: 'Video 6', videoImageUrl: 'https://ts1.cn.mm.bing.net/th/id/R-C.723adea0d010c5cc8ab3f4dc39c32df7?rik=FcF2o3BM%2fte5fg&riu=http%3a%2f%2fss605.com%2fuploadfiles%2fimage%2f20201225%2f20201225162327312731.jpg&ehk=Rjq4BD89O5Th1G6ycl6xGhSTiCA5mOZr4DaR5I1bdik%3d&risl=&pid=ImgRaw&r=0',videoCount: 4,videoContent: "测试6",),
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
                itemCount: videoInfos.length,
                itemBuilder: (context,index) {
                  return SizedBox(
                        width: 800, height: 120,

                        child: InkWell(onTap: () {
                          // 在这里添加你的点击事件处理逻辑
                          print('视频信息 $index 被点击');
                        },
                        child: videoInfos[index]));
                }
            ),
          ),
          ],
    );
  }
}