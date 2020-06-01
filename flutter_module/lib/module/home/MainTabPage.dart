import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermodule/module/home/IndexPage.dart';
import 'package:fluttermodule/module/home/MinePage.dart';
import 'package:fluttermodule/module/home/StorePage.dart';
import 'package:fluttermodule/module/home/InvestPage.dart';

import '../../main.dart';

class MainTabPage extends StatefulWidget {
  final String title;

  const MainTabPage({Key key, this.title}) : super(key: key);

  @override
  _MainTabPageState createState() {
    return _MainTabPageState();
  }
}

class _Item {
  String name, activeIcon, normalIcon;
  int pos;

  _Item(this.name, this.activeIcon, this.normalIcon, this.pos);
}

class _MainTabPageState extends State<MainTabPage> {
  List<Widget> pages;
  final itemNames = [
    _Item('首页', 'assets/image/ic_tab_index_selected.png',
        'assets/image/ic_tab_index_normal.png', 0),
    _Item('投资', 'assets/image/ic_tab_product_selected.png',
        'assets/image/ic_tab_product_normal.png', 1),
    _Item('商城', 'assets/image/ic_tab_shop_selected.png',
        'assets/image/ic_tab_shop_normal.png', 2),
    _Item('我的', 'assets/image/ic_tab_mine_selected.png',
        'assets/image/ic_tab_mine_normal.png', 3),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(//AnnotatedRegion包裹Scaffold，设置状态栏字体颜色
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: new Stack(
            children: [
              _getPagesWidget(0),
              _getPagesWidget(1),
              _getPagesWidget(2),
              _getPagesWidget(3),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          bottomNavigationBar: BottomNavigationBar(
            items: itemList,
            onTap: (int index) {
              ///这里根据点击的index来显示，非index的page均隐藏
              setState(() {
                _selectIndex = index;
              });
            },
            //图标大小
            iconSize: 24,
            //当前选中的索引
            currentIndex: _selectIndex,
            //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
            fixedColor: Color.fromARGB(255, 255, 110, 52),
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }

  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    super.initState();
    if (pages == null) {
      pages = [IndexPage(), InvestPage(), StorePage(), MinePage()];
    }
    if (itemList == null) {
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
              icon: Image.asset(
                item.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              title: Text(
                item.name,
                style: TextStyle(fontSize: 10.0),
              ),
              activeIcon:
                  Image.asset(item.activeIcon, width: 30.0, height: 30.0)))
          .toList();
    }
  }

  int _selectIndex = 0;

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
      ),
    );
  }

//  Container renderBottomBar(BuildContext context) {
//    return Container(
//      height: 50,
//      alignment: Alignment.center,
//      width: MediaQuery.of(context).size.width,
//      color: white,
//      child: Row(
//        children: itemList,
//      ),
//    );
//  }

  Expanded addTab(String tab, String icon, int pos) {
    return Expanded(
      child: InkWell(
          child: Column(
            children: <Widget>[
              Image.asset(icon, height: 20, width: 20),
              Container(
                child: Text(tab, style: TextStyle(fontSize: 11)),
                margin: EdgeInsets.fromLTRB(0, 3, 0, 0),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          onTap: _onTabItemClick(pos)),
      flex: 1,
    );
  }

  AppBar renderTitleBar() {
    return AppBar(
        title: new Center(
          child: renderTitle(),
        ),
        backgroundColor: white,
        automaticallyImplyLeading: false);
  }

  Text renderTitle() => Text(
        widget.title,
        style: TextStyle(color: Colors.black, fontSize: 20),
      );

  _onTabItemClick(int pos) {
    setState(() {
      _selectIndex = pos;
    });
  }
}
