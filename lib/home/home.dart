

import 'package:flutter/cupertino.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _PageHomeState();

}


class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Text("首页");
  }

}