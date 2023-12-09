import 'package:flutter/material.dart';
import 'package:my_app_1/home/home.dart';
import 'package:my_app_1/amusement/amusement.dart';

import '../user/Profile/profileHomePage.dart';
import '../user/model/User.dart';
import '../utils/tabBar/CircularBottomNavigation.dart';
import '../utils/tabBar/TabItem.dart';




class MyLayout extends StatefulWidget{
  MyLayout({super.key,required this.title, required this.user,});
  final String title;
  final User user;
  @override
  State<StatefulWidget> createState() => _MyLayoutState();
}
///  自己定义的布局
class _MyLayoutState extends State<MyLayout> {

  static int _selectedIndex = 0;

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index!;
    });
  }

  // 底部导航栏各个可切换页面组
  final List<Widget> _bottomNavPages = [];

  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "首页", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.video_chat, "娱乐", Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.supervised_user_circle, "我的", Colors.red, circleStrokeColor: Colors.black),
  ]);
  CircularBottomNavigationController _navigationController =
  new CircularBottomNavigationController(_selectedIndex);
  @override
  void initState() {
    super.initState();
    // _bottomNavPages..add(const PageHome(title: '首页',))..add(const PageAmusement(title: '娱乐',))..add(PageUser(title: '我的',isLogin: widget.isLogin,));
    _bottomNavPages..add(const PageHome(title: '首页',))..add(const PageAmusement(title: '娱乐',))..add(ProfileOnePage(widget.user));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:   _bottomNavPages[_selectedIndex],
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        selectedPos: _selectedIndex,
        selectedCallback: _onItemTapped,
      )
    );
  }

}