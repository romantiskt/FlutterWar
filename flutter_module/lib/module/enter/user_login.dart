import 'package:flutter/material.dart';
import 'package:fluttermodule/config/application.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State {
  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  Widget _getBody() {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Text("去登录"),
          ),
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //修改颜色
              ),
              title: Text(
                "登录",
                style: TextStyle(color: Color(0xFF000000)),
              ),
              backgroundColor: white,
              automaticallyImplyLeading: true),
        ),
        onWillPop: onBack);
  }

  Future<bool> onBack() {
    Application.router.pop(context);
    return new Future.value(false);
  }
}
