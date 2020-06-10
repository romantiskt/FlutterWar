import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttermodule/util/LogUtils.dart';

typedef void Success(Object data);
typedef void Failed(String code, String errorMsg);

class Api {
  factory Api() => _getInstance();

  static Api get instance => _getInstance();
  static Api _instance;
  MethodChannel network = const MethodChannel('native_network');
  String baseUrl =
      "https://www.fastmock.site/mock/596f8699defc6f723bd948351260e0a7/flutter/";

  Api._internal() {
    // 初始化
  }

  static Api _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }

  Future<void> get(String url, Map params,
      {Success success, Failed failed}) async {
    try {
      if (params == null) {
        params = Map<String, String>();
      }
      params["url"] = baseUrl + url;
      String response = await network.invokeMethod("get", params);
      if (response != null && response.isNotEmpty) {
        var decodeStr = json.decode(response);
        if (decodeStr['code'] == '0') {
          success( decodeStr["data"]);
        } else {
          failed(decodeStr['code'], decodeStr['msg']==null?"网络开小差了,请稍后再试":decodeStr['msg']);
        }
      } else {
        failed("-2", "response is null");
      }
    } on PlatformException catch (e) {
      failed("-1", e.message);
    }
  }
}
