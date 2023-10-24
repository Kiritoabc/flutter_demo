import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, required this.videoImageUrl, required this.videoTitle, required this.videoCount, required this.videoContent}) : super(key: key);

  final String videoImageUrl;
  final String videoTitle;
  final int videoCount;
  final String videoContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Image.network(
          videoImageUrl,
          width: 120,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(videoTitle, style: TextStyle(fontSize: 16)),
            Text('共 $videoCount 集', style: TextStyle(fontSize: 14)),
            Text(videoContent,style: TextStyle(fontSize: 14),)
          ],
        ),
      ],
    );
  }
}
