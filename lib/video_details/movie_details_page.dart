import 'package:flutter/material.dart';
import 'package:my_app_1/video_details/photo_scroller.dart';
import 'package:my_app_1/video_details/story_line.dart';

import 'actor_scroller.dart';
import 'models.dart';
import 'movie_detail_header.dart';


class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage(this.movie);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("movie",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(movie),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Storyline(movie.storyline),
            ),
            PhotoScroller(movie.photoUrls,movie.movieUrls),
            SizedBox(height: 20.0),
            // ActorScroller(movie.actors),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
