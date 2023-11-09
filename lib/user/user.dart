import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login/login_screen.dart';


class PageUser extends StatefulWidget {
  PageUser({super.key, required this.title,this.isLogin = false});

  final String title;

  bool isLogin;
  @override
  State<StatefulWidget> createState() => _PageUserState();

}

class _PageUserState extends State<PageUser> {
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    // 设置用户登录状态
    setState(() {
      _isLoggedIn = widget.isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isLoggedIn
                ? Text(
              '欢迎回来！待开发中！',
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