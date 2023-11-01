import 'package:flutter/material.dart';
import 'package:my_app_1/component/video_screen.dart';
import 'player_page.dart';
import 'videoPlayer.dart';


class PageViewExampleApp extends StatelessWidget {
  const PageViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageViewExample();
  }
}

class PageViewExample extends StatelessWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      scrollDirection: Axis.vertical,
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: <Widget>[
        FijkPlayerExample(),
        Center(
          child: PlayerPage(),
        ),
        Center(
          child: PlayerPage(),
        ),
      ],
    );
  }
}
