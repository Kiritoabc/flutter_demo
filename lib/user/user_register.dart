import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_1/user/user_login.dart';
import 'package:my_app_1/utils/dio_util.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key, required this.title});

  final String title;
  @override
  State<StatefulWidget> createState() => _PageUserState();

}

class _PageUserState extends State<PageRegister> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _phoneNumber = '';
  String _email = '';
  String _nickname = '';

  // 测试请求
  void Register() async {
    Response response;
    // 数据准备
    var formData = FormData.fromMap({
      "userName": _username,
      "password": _password,
      "phone": _phoneNumber,
      "email": _email,
      "nickName": _nickname,
    });
    HttpUtils.init();
    HttpUtils.post("/user/register",data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PageLogin()));
              },
              child: Text('登录'),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(padding: EdgeInsets.all(16)),
                TextFormField(
                  decoration: InputDecoration(labelText: '用户名', prefixIcon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入用户名';
                    }
                    return null;
                  },
                  onSaved: (value) => _username = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '密码', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入密码';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '手机号', prefixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入手机号';
                    }
                    return null;
                  },
                  onSaved: (value) => _phoneNumber = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '邮箱', prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入邮箱';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '昵称', prefixIcon: Icon(Icons.account_circle)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入昵称';
                    }
                    return null;
                  },
                  onSaved: (value) => _nickname = value.toString(),
                ),
                InkWell(
                  onTap: () async {
                    // 验证数据的合法性
                    if (_formKey.currentState!.validate()) {
                      // 在这里处理用户注册登录逻辑，例如调用API等
                      // 保存数据
                      _formKey.currentState?.save();
                      print('用户名：$_username');
                      print('密码：$_password');
                      print('手机号：$_phoneNumber');
                      print('邮箱：$_email');
                      print('昵称：$_nickname');
                      // print('头像：$_avatarImage');
                    } else {
                      print('表单验证失败');
                    }
                  },
                  child: Opacity(
                    opacity: 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        // todo: 测试一哈
                        Register();
                      },
                      child: Text('提交'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
