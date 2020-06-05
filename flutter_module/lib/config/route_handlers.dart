import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/module/enter/user_login.dart';
import 'package:fluttermodule/module/home/main_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainTabPage();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var notFoundHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print("ROUTE WAS NOT FOUND !!!");
  return null;
});
