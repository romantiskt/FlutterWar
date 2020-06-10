import 'package:flutter/material.dart';
import 'package:fluttermodule/base/base_widget.dart';
import 'package:fluttermodule/config/application.dart';

import '../../main.dart';

class LoginPage extends BaseWidget {
  @override
  BaseWidgetState<BaseWidget> getState() {
    return LoginPageState();
  }
}

class LoginPageState extends BaseWidgetState<BaseWidget> {
  @override
  void initState() {
    super.initState();
    setTopBarVisible(true);
    setAppBarVisible(false);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return _getBody();
  }

  Widget _getBody() {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Text("去登录"),
          ),
        ),
        onWillPop: onBack);
  }

  Future<bool> onBack() {
    Application.router.pop(context);
    return new Future.value(false);
  }
}
