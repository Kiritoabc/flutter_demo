
import 'package:flutter/material.dart';
import 'package:my_app_1/video_details/poster.dart';
import 'package:my_app_1/video_details/rating_information.dart';

import '../component/chewieDemo.dart';
import 'arc_banner_image.dart';
import 'models.dart';


class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movie);
  final Movie movie;




  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    List<Widget> _buildCategoryChips(TextTheme textTheme) {
      return movie.categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () {
              // 在这里添加点击事件处理逻辑
              print("Play Vide");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChewieDemo(ParentId: movie.ParentId,title: movie.title,)),
              );
            },
            child: Chip(
              label: Text(category),
              labelStyle: textTheme.caption,
              backgroundColor: Colors.blue,
            ),
          ),
        );
      }).toList();
    }


    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          // style: textTheme.title,
        ),
        SizedBox(height: 8.0),
        RatingInformation(movie),
        SizedBox(height: 12.0),
        Row(children: _buildCategoryChips(textTheme)),
      ],
    );



    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(movie.bannerUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Poster(
                movie.posterUrl,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
