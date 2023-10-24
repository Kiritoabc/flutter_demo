import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, required this.videoImageUrl, required this.videoTitle, required this.videoCount}) : super(key: key);

  final String videoImageUrl;
  final String videoTitle;
  final int videoCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          videoImageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(videoTitle, style: TextStyle(fontSize: 16)),
            Text('共 $videoCount 集', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
