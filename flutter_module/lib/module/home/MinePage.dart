import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttermodule/util/LogUtils.dart';

class DataMineWrapper {
  String type;
  List<BannerEntity> banner;

  static const String TYPE_HEAD = "type_head";
  static const String TYPE_BANNER = "type_banner";
  static const String TYPE_ITEM = "type_item";

  DataMineWrapper(this.type);
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
  static const network = const MethodChannel('native_network');
  EasyRefreshController _controller = EasyRefreshController();
  List<DataMineWrapper> _list;
  String _nativeStr;

  @override
  Future<void> initState() {
    super.initState();
    LogUtils.d("wang", "initState");
    List<DataMineWrapper> list = new List<DataMineWrapper>();
    list.add(DataMineWrapper(DataMineWrapper.TYPE_HEAD));
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

    testNative();

    var i = 0;
    while (i++ < 100) {
      list.add(DataMineWrapper(DataMineWrapper.TYPE_ITEM));
    }
    setState(() {
      _list = list;
    });
  }

  Future<void> testNative() async {
    String batteryLevel;
    try {
      final String result = await network.invokeMethod('test');
      batteryLevel = 'Battery level at $result % .';

      String response = await network.invokeMethod("get");
      LogUtils.d("wang", response);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    LogUtils.d("wang", batteryLevel);
    setState(() {
      _nativeStr = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    LogUtils.d("wang", "build");
    return Scaffold(
        body: EasyRefresh(
      enableControlFinishRefresh: true,
      controller: _controller,
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        _controller.finishRefresh(success: true);
      },
      child: _getBody(),
//      slivers: <Widget>[
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//            (context, index) {
//              return inflateItemView(index);
//            },
//            childCount: _list.length,
//          ),
//        ),
//      ],
    ));
  }

  Widget inflateItemView(int index) {
    switch (_list[index].type) {
      case DataMineWrapper.TYPE_HEAD:
        return _getHeadByNotLogin();
      case DataMineWrapper.TYPE_ITEM:
        return Text("我是一条item");
      case DataMineWrapper.TYPE_BANNER:
        return _getBanner(index);
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
          child: Text(
            "欢迎你, 新朋友",
            style: TextStyle(
              color: Color(0XFF3D3F48),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_nativeStr == null ? "hello" : _nativeStr),
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
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
    );
  }

  Widget _getBody() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return inflateItemView(index);
      },
      itemCount: _list.length,
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
}
