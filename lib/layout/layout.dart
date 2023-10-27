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
  final List<Widget> _bottomNavPages = [];


  @override
  void initState() {
    super.initState();
    _bottomNavPages..add(const PageHome(title: '首页',))..add(const PageAmusement(title: '娱乐',))..add(const PageUser(title: '我的',));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title,
          style: const TextStyle(
          color: Colors.black87, // 设置字体颜色
              fontSize: 20,   // 设置字体大小
            ),
          ),
        titleSpacing: 10,
        elevation: 0, // 隐藏底部阴影分割线
        centerTitle: true, // 标题是否剧中
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          )
        ],
      ),
      body:  _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
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