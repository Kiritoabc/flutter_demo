import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app_1/utils/dio_util.dart';

import '../../../component/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../layout/layout.dart';
import '../../Signup/signup_screen.dart';
import '../../model/User.dart';
import '../../user.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: _usernameController,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your UserName",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                // todo 测试登录注册接口
                HttpUtils.init();
                Response res;
                res = await HttpUtils.post("/user/login",data: {
                  "userName": _usernameController.text,
                  "password": _passwordController.text,
                });
                if(res.data["code"] == 0) {
                  Fluttertoast.showToast(
                      msg: "Login SUCCESS",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.blue,
                      fontSize: 16.0
                  );
                  print(res.data['data']);
                  //{user: {ID: 1,
                  //        CreatedAt: 2023-11-09T09:32:04.536+08:00,
                  //        UpdatedAt: 2023-11-09T09:32:04.536+08:00,
                  //        uuid: d3fd1a74-15d1-4990-99cc-fc1073d29ba8,
                  //        userName: kirito,
                  //        password: $2a$10$31wawQLGbBBT.Tls.5Tkce5F1sJawjcfqwwbPiEBuXw/8qXrPyQsa,
                  //        nickName: 系统用户,
                  //        headerImg: https://ts1.cn.mm.bing.net/th/id/R-C.e3506e1ab5441c8c9c43facfba9ff1ab?rik=JKbGTz1jQYhGuA&riu=http%3a%2f%2fwww.gx8899.com%2fuploads%2fallimg%2f2018031109%2fqzfrr5ly3af.jpg&ehk=izdYHSNuzDYZQF2HdyA6xZ3Jgz5lXaj%2faZHquTh2FvU%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1,
                  //        phone: ,
                  //        email: ,
                  //        enable: 1,
                  //        role: 1
                  //        }
                  // }
                  User user = User(
                      ID: res.data['data']['user']['ID'],
                      userName: res.data['data']['user']['userName'],
                      nickName: res.data['data']['user']['userName'],
                      headerImg: res.data['data']['user']['headerImg'],
                      phone: res.data['data']['user']['phone'],
                      email: res.data['data']['user']['email'],
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // 跳转到Layout，
                        builder: (context) => MyLayout(title: 'Chinese Learning App',userName:_usernameController.text)
                    )
                  );
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
