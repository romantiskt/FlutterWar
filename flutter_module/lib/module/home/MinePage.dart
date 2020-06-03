import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttermodule/core/Api.dart';
import 'package:fluttermodule/entity/Constants.dart';
import 'package:fluttermodule/util/LogUtils.dart';

class DataMineWrapper {
  String type;
  List<BannerEntity> banner;
  List<GridEntity> grid;

  static const String TYPE_HEAD = "type_head";
  static const String TYPE_BANNER = "type_banner";
  static const String TYPE_ITEM = "type_item";
  static const String TYPE_GRID = "type_grid";

  DataMineWrapper(this.type);
}

class GridEntity {
  String image, text, url;

  GridEntity(this.image, this.text, this.url);
}

class BannerEntity {
  String image, url;

  BannerEntity(this.image, this.url);
}

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  EasyRefreshController _controller = EasyRefreshController();
  List<DataMineWrapper> _list;

  @override
  Future<void> initState() {
    super.initState();
    LogUtils.d("wang", "initState");

    requestData();
  }

  Future<void> requestData() async {
    List<DataMineWrapper> list = List();
    var params = Map<String, String>();
    Api.instance.get("page/my", params, success: (Object data) {
      var dataMap = data as Map;
      LogUtils.d("wang", "response $data");
      List dataList = dataMap["modules"];
      for (var i = 0; i < dataList.length; i++) {
        Map dataListEntity = dataList[i];
        var type = dataListEntity['type'];
        switch (dataListEntity['type'].toString()) {
          case Constants.TYPE_600:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_HEAD));
            break;
          case Constants.TYPE_601:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_GRID));
            break;
          case Constants.TYPE_602:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_ITEM));
            break;
          case Constants.TYPE_603:
            var bannerWrapper = DataMineWrapper(DataMineWrapper.TYPE_BANNER);
            List<BannerEntity> bannerList = new List();
            bannerList.add(BannerEntity(
                "https://images.jyblife.com/prd/6.0icon/jiayou.png",
                "https://www.baidu.com"));
            bannerList.add(BannerEntity(
                "https://images.jyblife.com/prd/6.0icon/licai.png",
                "https://www.baidu.com"));
            bannerList.add(BannerEntity(
                "https://images.jyblife.com/prd/6.0icon/jiayou.png",
                "https://www.baidu.com"));
            bannerWrapper.banner = bannerList;
            list.add(bannerWrapper);
            break;
          case Constants.TYPE_604:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_ITEM));
            break;
          case Constants.TYPE_605:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_GRID));
            break;
          case Constants.TYPE_606:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_GRID));
            break;
        }
      }
      setState(() {
        _list = list;
      });
    }, failed: (String code, String msg) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  Widget inflateItemView(int index) {
    var type = _list[index].type;
    switch (type) {
      case DataMineWrapper.TYPE_HEAD:
        return _getHeadByNotLogin();
      case DataMineWrapper.TYPE_ITEM:
        return Text("我是一条item");
      case DataMineWrapper.TYPE_BANNER:
        return _getBanner(index);
      case DataMineWrapper.TYPE_GRID:
        return _getGrid(index);
      default:
        return Text("我是一条默认的item");
    }
  }

  Widget _getHeadByNotLogin() {
    return Container(
      child: Column(children: [
        Image.asset('assets/image/ic_mine_head_unlogin.png',
            height: 85, width: 85),
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text(
              "欢迎你, 新朋友",
              style: TextStyle(
                color: Color(0XFF3D3F48),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onTap: requestData,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("登录/注册"),
              Image.asset(
                'assets/image/ic_arrow_right_black.png',
                height: 10,
                width: 10,
              )
            ],
          ),
          margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
        )
      ]),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    );
  }

  Widget _getBody() {
    LogUtils.d("wang", "list size $_list.length");
    var views = List<Widget>();
    for (var i = 0; i < _list.length; i++) {
      views.add(inflateItemView(i));
    }
    return ListView(
      children: [
        Column(
          children: views,
        )
      ],
    );
  }

  Widget _getBanner(int index) {
    var bannerList = _list[index];
    return Container(
      height: 140,
      margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Swiper(
        itemCount: bannerList.banner.length,
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            bannerList.banner[index].image,
            fit: BoxFit.fill,
          );
        },
        duration: 1000,
        autoplay: true,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xFFACAFBF), size: 6, activeSize: 6)),
      ),
    );
  }

  Widget _getGrid(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: GridView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 4,
              //纵轴间距
              mainAxisSpacing: 10.0,
              //横轴间距
              crossAxisSpacing: 10.0),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return getItemContainer();
          }),
    );
  }

  Widget getItemContainer() {
    return Container(
      child: Expanded(
        child: Column(
          children: [
            Image.asset("assets/image/ic_mine_head_unlogin.png",
                height: 60, fit: BoxFit.cover),
            Text("hello jack")
          ],
        ),
      ),
    );
  }
}
