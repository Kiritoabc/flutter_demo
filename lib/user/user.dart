
import 'package:flutter/cupertino.dart';

class PageUser extends StatefulWidget {
  const PageUser({super.key, required this.title});

  final String title;
  @override
  State<StatefulWidget> createState() => _PageUserState();

}


class _PageUserState extends State<PageUser> {
  @override
  Widget build(BuildContext context) {
    return Text("用户界面");
  }

}