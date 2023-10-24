import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/home/home.dart';
import 'package:my_app_1/user/user.dart';
import 'package:my_app_1/amusement/amusement.dart';




class MyLayout extends StatefulWidget{
  const MyLayout({super.key,required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _MyLayoutState();

}

///  自己定义的布局
class _MyLayoutState extends State<MyLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 底部导航栏各个可切换页面组
  List<Widget> _bottomNavPages = []; // 底部导航栏各个可切换页面组


  void initState() {
    super.initState();
    _bottomNavPages..add(PageHome(title: '首页',))..add(PageAmusement(title: '娱乐',))..add(PageUser(title: '我的',));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.video_chat),label: "娱乐"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle),label: "我的")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

}