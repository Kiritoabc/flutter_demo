import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/user/user_login.dart';

import 'Login/login_screen.dart';


class PageUser extends StatefulWidget {
  const PageUser({super.key, required this.title});

  final String title;
  @override
  State<StatefulWidget> createState() => _PageUserState();

}

class _PageUserState extends State<PageUser> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // 模拟用户登录状态，可以根据实际情况从数据库或其他地方获取
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // _isLoggedIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isLoggedIn
                ? Text(
              '欢迎回来！',
              style: TextStyle(fontSize: 24.0),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '请先登录',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    print("hello");
                    // 跳转到登录页面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('登录'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}