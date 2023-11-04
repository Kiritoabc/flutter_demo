import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, required this.videoIconUrl, required this.videoName, required this.number, required this.content}) : super(key: key);

  final String videoIconUrl;
  final String videoName;
  final int number;
  final String content;

  @override
  Widget build(BuildContext context) {
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
                      child: Image.network(
                        videoIconUrl,
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '主题: $videoName',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  '共 $number 集',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 5),
                Text(
                  '描述:$content',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
