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
      VideoInfo(videoTitle: 'Video 3', videoImageUrl: 'https://tse3-mm.cn.bing.net/th/id/OIP-C.z30umoh6fUAJ-m1musuZNwHaEo?pid=ImgDet&rs=1',videoCount: 4,videoContent: "测试4",),
      VideoInfo(videoTitle: 'Video 3', videoImageUrl: 'https://tse3-mm.cn.bing.net/th/id/OIP-C.z30umoh6fUAJ-m1musuZNwHaEo?pid=ImgDet&rs=1',videoCount: 4,videoContent: "测试5",),
      VideoInfo(videoTitle: 'Video 3', videoImageUrl: 'https://tse3-mm.cn.bing.net/th/id/OIP-C.z30umoh6fUAJ-m1musuZNwHaEo?pid=ImgDet&rs=1',videoCount: 4,videoContent: "测试6",),
    ];

    // 返回
    return ListView.builder(
      itemCount: videoInfos.length,
      itemBuilder: (context,index) {
        return SizedBox(
          width: 800, height: 110,
            child: InkWell(onTap: () {
                  // 在这里添加你的点击事件处理逻辑
                  print('视频信息 $index 被点击');
                },
            child: videoInfos[index]));
      }
    );
  }
}