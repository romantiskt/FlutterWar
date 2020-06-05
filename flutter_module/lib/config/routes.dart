
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttermodule/config/route_handlers.dart';

class Routes {
  static String root = "/";
  static String enterLogin="/enter/login";

  static void configureRoutes(Router router) {
    router.define(enterLogin, handler: loginHandler);
    router.define(root, handler: rootHandler);
  }

}