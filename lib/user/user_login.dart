import 'package:flutter/material.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '用户名'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入用户名';
                }
                return null;
              },
              onSaved: (value) => _username = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入密码';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // 在这里处理登录逻辑，例如调用API等
                  print('用户名：$_username');
                  print('密码：$_password');
                  Navigator.pushNamed(context, '/home'); // 跳转到主页
                } else {
                  print('表单验证失败');
                }
              },
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
