import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermodule/main.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = List();
    var i = 100;
    while (i < 100) {
      list[i] = Text("hello");
    }
    return Scaffold(
      body: Column(
        children: [Text("hello"),Text("hello"),Text("hello")],
      ),
      appBar: AppBar(
          title: new Center(
            child: Text(
              "首页",
              style: TextStyle(color: Color(0xFF000000)),
            ),
          ),
          backgroundColor: white,
          automaticallyImplyLeading: false),
    );
  }
}
