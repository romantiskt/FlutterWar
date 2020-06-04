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
import 'package:fluttermodule/entity/mine_page_entity.dart';
import 'package:fluttermodule/util/LogUtils.dart';

class DataMineWrapper {
  String type;
  String title;
  List<BannerEntity> banner;
  List<GridEntity> grid;

  static const String TYPE_HEAD = "type_head";
  static const String TYPE_BANNER = "type_banner";
  static const String TYPE_ITEM = "type_item";
  static const String TYPE_GRID = "type_grid";
  static const String TYPE_TITLE = "type_title";
  static const String TYPE_ACTIVITY = "type_activity";

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
      var minePageEntity = MinePageEntity.fromJson(data);
      LogUtils.d("wang", "response $minePageEntity");
      for (var i = 0; i < minePageEntity.modules.length; i++) {
        var module = minePageEntity.modules[i];
        if (module.title != null) {
          var titleWrapper = DataMineWrapper(DataMineWrapper.TYPE_TITLE);
          titleWrapper.title = module.title;
          list.add(titleWrapper);
        }
        switch (module.type.toString()) {
          case Constants.TYPE_600:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_HEAD));
            break;
          case Constants.TYPE_601:
            addGridItem(module, list);
            break;
          case Constants.TYPE_602:
            list.add(DataMineWrapper(DataMineWrapper.TYPE_ITEM));
            break;
          case Constants.TYPE_603:
            List<BannerEntity> bannerList = new List();
            var bannerWrapper = DataMineWrapper(DataMineWrapper.TYPE_BANNER);
            for (int i = 0; i < module.items.length; i++) {
              bannerList.add(
                  BannerEntity(module.items[i].image, module.items[i].url));
            }
            bannerWrapper.banner = bannerList;
            list.add(bannerWrapper);
            break;
          case Constants.TYPE_604:
            List<GridEntity> gridList = new List();
            for (int i = 0; i < module.items.length; i++) {
              gridList.add(GridEntity(module.items[i].image,
                  module.items[i].text, module.items[i].url));
            }
            var gridWrapper = DataMineWrapper(DataMineWrapper.TYPE_ACTIVITY);
            gridWrapper.grid = gridList;
            list.add(gridWrapper);
            break;
          case Constants.TYPE_605:
            addGridItem(module, list);
            break;
          case Constants.TYPE_606:
            addGridItem(module, list);
            break;
        }
      }
      setState(() {
        _list = list;
      });
    }, failed: (String code, String msg) {
      LogUtils.d("wang", "请求失败$msg");
    });
  }

  void addGridItem(Modules module, List<DataMineWrapper> list) {
    List<GridEntity> gridList = new List();
    for (int i = 0; i < module.items.length; i++) {
      gridList.add(GridEntity(
          module.items[i].image, module.items[i].text, module.items[i].url));
    }
    var gridWrapper = DataMineWrapper(DataMineWrapper.TYPE_GRID);
    gridWrapper.grid = gridList;
    list.add(gridWrapper);
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
      case DataMineWrapper.TYPE_TITLE:
        return _getTitle(index);
      case DataMineWrapper.TYPE_ACTIVITY:
        return _getActivity(index);
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
    if (_list == null)
      return GestureDetector(
        onTap: requestData,
        child: Container(
          height: 100,
          child: Text("网络错误了哦"),
          margin: EdgeInsets.all(40),
        ),
      );
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
    var gridWrapper = _list[index];
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: GridView.builder(
          itemCount: gridWrapper.grid.length,
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
            return getItemContainer(gridWrapper.grid[index]);
          }),
    );
  }

  Widget getItemContainer(GridEntity grid) {
    return Container(
      child: Expanded(
        child: Column(
          children: [
            Image.network(grid.image, height: 60, fit: BoxFit.cover),
            Text(grid.text)
          ],
        ),
      ),
    );
  }

  Widget _getTitle(int index) {
    var titleWrapper = _list[index];
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
      alignment: Alignment.bottomLeft,
      child: Text(
        titleWrapper.title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 18,
            color: Color(0xFF3D3F48),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getActivity(int index) {
    var grid = _list[index].grid;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.network(grid[0].image, fit: BoxFit.cover),
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: 4,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Image.network(grid[1].image, fit: BoxFit.cover),
                Container(height: 4,),
                Image.network(grid[3].image, fit: BoxFit.cover),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: 4,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Image.network(grid[2].image, fit: BoxFit.cover),
                Container(height: 4,),
                Image.network(grid[4].image, fit: BoxFit.cover),
              ],
            ),
          )
        ],
      ),
    );
  }
}
