import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/utils/dio_util.dart';
import 'package:my_app_1/video_details/models.dart';
import 'package:my_app_1/video_details/movie_api.dart';
import 'package:my_app_1/video_details/movie_details_page.dart';

import '../utils/config.dart';
import 'chewieDemo.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, required this.videoIconUrl, required this.videoName, required this.number, required this.content, required this.ID}) : super(key: key);

  final String videoIconUrl;
  final String videoName;
  final int number;
  final String content;
  final int ID;

  @override
  Widget build(BuildContext context) {

    String MyIp = Config.myIp;

    String minioPort = Config.minioPort;

    String goBackend = Config.goBackend;


    final dio = new Dio();
    Future<Response> SearchAllVideoList() async {
      Response response;
      var formData = FormData.fromMap({
        'ParentId': ID,
      });
      HttpUtils.init();
      response = await HttpUtils.post('/teachingVideo/getTeachingSonVideoList',data: formData);
      return response;
    }
    // 跳转记录
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: 120,
                    width:  120,
                    child:Stack(
                      children: [
                        Image.network(
                          videoIconUrl,
                          width: 120,
                          height: 100,
                          fit: BoxFit.cover
                        ),
                        Align(
                          alignment: Alignment(0.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: InkWell(
                              child: IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () async {
                                  Response res = await SearchAllVideoList() ;
                                  List<dynamic> dataList = res.data['data']['list'];
                                  // todo: 给movie赋值
                                  Movie movie = Movie(
                                    bannerUrl: videoIconUrl,
                                    posterUrl: videoIconUrl,
                                    title: videoName,
                                    rating: 8.0,
                                    starRating: 4,
                                    categories: ['Play Video', 'Comedy'],
                                    storyline: res.data['data']['list'][0]['content'],
                                    photoUrls: [],
                                    movieUrls: [],
                                    actors: [
                                      Actor(
                                        name: 'Louis C.K.',
                                        avatarUrl: 'images/louis.png',
                                      ),
                                      Actor(
                                        name: 'Eric Stonestreet',
                                        avatarUrl: 'images/eric.png',
                                      ),
                                      Actor(
                                        name: 'Kevin Hart',
                                        avatarUrl: 'images/kevin.png',
                                      ),
                                      Actor(
                                        name: 'Jenny Slate',
                                        avatarUrl: 'images/jenny.png',
                                      ),
                                      Actor(
                                        name: 'Ellie Kemper',
                                        avatarUrl: 'images/ellie.png',
                                      ),
                                    ], ParentId: ID,
                                  );
                                  // 添加 photoUrls,movieUrls赋值
                                  for(int i = 0; i < dataList.length; i++) {
                                    movie.photoUrls.add(MyIp + minioPort+ dataList[i]['videoIcon']);
                                    movie.movieUrls.add(MyIp + minioPort + dataList[i]['videoUrl']);
                                  }
                                  Navigator.push(
                                    context,
                                    // MaterialPageRoute(builder: (context) => ChewieDemo(ParentId: ID,title: videoName,)),
                                    MaterialPageRoute(builder: (context) => MovieDetailsPage(movie))
                                  );
                                  print("hello flutter");
                                },
                                color: Colors.blueAccent,
                                iconSize: 40,
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '标题： $videoName',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '共 $number 集',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Container(
                    // color: Colors.amber.shade100,
                    height: 500,
                    width: 150,
                    child: Text(
                      '描述：$content',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        // color: Colors.black87
                      ),
                      // overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      textDirection: TextDirection.ltr,
                      softWrap: true,
                    ),
                  ),
                ),
                // SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
