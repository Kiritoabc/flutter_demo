import 'package:flutter/cupertino.dart';
// import 'package:my_app_1/component/videoPlayer.dart';
import 'package:my_app_1/component/videoList.dart';

class PageAmusement extends StatefulWidget{
  const PageAmusement({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _PageAmusementState();

}


class _PageAmusementState extends State<PageAmusement> {
  @override
  Widget build(BuildContext context) {
    return  const PageViewExampleApp();
  }

}