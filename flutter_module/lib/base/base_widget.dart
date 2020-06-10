import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseWidget extends StatefulWidget {
  BaseWidgetState baseWidgetState;

  @override
  BaseWidgetState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  String _appBarTitle;
  String _appBarRightTitle; //小标题信息

  String _errorContentMesage = "网络错误啦~~~";
  String _errImgPath = "assets/image/ic_network_timeout.png"; //自己根据需求变更

  FontWeight _fontWidget = FontWeight.w600; //错误页面和空页面的字体粗度

  double bottomVsrtical = 0; //作为内部页面距离底部的高度

  bool _isTopBarShow = true; //状态栏是否显示
  bool _isAppBarShow = true; //导航栏是否显示
  bool _isErrorWidgetShow = false; //错误信息是否显示
  bool _isLoadingWidgetShow = false;
  bool _isBackIconShow = true;

  Color _topBarColor = Colors.blue;
  Color _appBarColor = Colors.blue;
  Color _appBarContentColor = Colors.white;
  double _appBarRightTextSize = 15.0;
  double _appBarCenterTextSize = 20; //标题字体大小

  @override
  void initState() {
    initBaseCommon(this);
    super.initState();
  }

  void initBaseCommon(State state) {
    _appBarTitle = "默认标题";
    _appBarRightTitle = "标题二";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBaseView(context),
    );
  }

  Widget getBaseView(BuildContext context) {
    return Column(
      children: <Widget>[
        _isTopBarShow ? _getBaseTopBar() : _getHolderLWidget(),
        _isAppBarShow ? _getBaseAppBar() : _getHolderLWidget(),
        Container(
          width: getScreenWidth(),
          height: getMainWidgetHeight(),
          color: Colors.white, //背景颜色，可自己变更
          child: Stack(
            children: <Widget>[
              _buildProviderWidget(context),
              _isErrorWidgetShow ? _getBaseErrorWidget() : _getHolderLWidget(),
              _isLoadingWidgetShow
                  ? _getBassLoadingWidget()
                  : _getHolderLWidget(),
            ],
          ),
        ),
      ],
    );
  }

  ///返回 状态管理组件
  _buildProviderWidget(BuildContext context) {
    return MultiProvider(
        providers: getProvider() == null ? [] : getProvider(),
        child: buildWidget(context));
  }

  //可以复写
  List<SingleChildCloneableWidget> getProvider() {
    return null;
  }

  Widget _getHolderLWidget() {
    return Container(
      width: 0,
      height: 0,
    );
  }

  Widget _getBaseTopBar() {
    return getTopBar();
  }

  Widget _getBaseAppBar() {
    return getAppBar();
  }

  ///设置状态栏，可以自行重写拓展成其他的任何形式
  Widget getTopBar() {
    return Container(
      height: getTopBarHeight(),
      width: double.infinity,
      color: _topBarColor,
    );
  }

  ///暴露的错误页面方法，可以自己重写定制
  Widget getErrorWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: InkWell(
          onTap: onClickErrorWidget,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(_errImgPath),
                width: 150,
                height: 150,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(_errorContentMesage,
                    style: TextStyle(
                      fontWeight: _fontWidget,
                    )),
              ),
              GestureDetector(
                child: Text("点击重试",style: TextStyle(fontWeight: _fontWidget),),
                onTap: retryClick,
              )
            ],
          ),
        ),
      ),
    );
  }

  ///返回中间可绘制区域，也就是 我们子类 buildWidget 可利用的空间高度
  double getMainWidgetHeight() {
    double screenHeight = getScreenHeight() - bottomVsrtical;

    if (_isTopBarShow) {
      screenHeight = screenHeight - getTopBarHeight();
    }
    if (_isAppBarShow) {
      screenHeight = screenHeight - getAppBarHeight();
    }

    return screenHeight-60;
  }

  ///返回屏幕高度
  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  ///返回状态栏高度
  double getTopBarHeight() {
    return MediaQuery.of(context).padding.top;
  }

  ///返回appbar高度，也就是导航栏高度
  double getAppBarHeight() {
    return kToolbarHeight;
  }

  ///返回屏幕宽度
  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  Widget _getBaseErrorWidget() {
    return getErrorWidget();
  }

  Widget _getBassLoadingWidget() {
    return getLoadingWidget();
  }

  ///导航栏 appBar 可以重写
  Widget getAppBar() {
    return Container(
      height: getAppBarHeight(),
      width: double.infinity,
      color: _appBarColor,
      child: Stack(
        alignment: FractionalOffset(0, 0.5),
        children: <Widget>[
          Align(
            alignment: FractionalOffset(0.5, 0.5),
            child: getAppBarCenter(),
          ),
          Align(
            //左边返回导航 的位置，可以根据需求变更
            alignment: FractionalOffset(0.02, 0.5),
            child: Offstage(
              offstage: !_isBackIconShow,
              child: getAppBarLeft(),
            ),
          ),
          Align(
            alignment: FractionalOffset(0.98, 0.5),
            child: getAppBarRight(),
          ),
        ],
      ),
    );
  }

  ///设置状态栏隐藏或者显示
  void setTopBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _isTopBarShow = isVisible;
      });
    }
  }

  ///默认这个状态栏下，设置颜色
  void setTopBarBackColor(Color color) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _topBarColor = color == null ? _topBarColor : color;
      });
    }
  }

  ///设置导航栏的字体以及图标颜色
  void setAppBarContentColor(Color contentColor) {
    if (contentColor != null) {
      if (mounted) {
        setState(() {
          _appBarContentColor = contentColor;
        });
      }
    }
  }

  ///设置导航栏隐藏或者显示
  void setAppBarVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _isAppBarShow = isVisible;
      });
    }
  }

  ///默认这个导航栏下，设置颜色
  void setAppBarBackColor(Color color) {
    if (mounted) {
      setState(() {
        _appBarColor = color == null ? _appBarColor : color;
      });
    }
  }

  void setAppBarTitle(String title) {
    if (title != null) {
      if (mounted) {
        setState(() {
          _appBarTitle = title;
        });
      }
    }
  }

  void setAppBarRightTitle(String title) {
    if (title != null) {
      if (mounted) {
        setState(() {
          _appBarRightTitle = title;
        });
      }
    }
  }

  ///设置错误提示信息
  void setErrorContent(String content) {
    if (content != null) {
      if (mounted) {
        setState(() {
          _errorContentMesage = content;
        });
      }
    }
  }

  ///设置错误页面显示或者隐藏
  void setErrorWidgetVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _isLoadingWidgetShow = false;
        _isErrorWidgetShow = isVisible;
      });
    }
  }

  void setLoadingWidgetVisible(bool isVisible) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _isLoadingWidgetShow = isVisible;
        _isErrorWidgetShow=false;
      });
    }
  }

  ///设置错误页面图片
  void setErrorImage(String imagePath) {
    if (imagePath != null) {
      if (mounted) {
        setState(() {
          _errImgPath = imagePath;
        });
      }
    }
  }


  void setBackIconHinde({bool isHiinde = true}) {
    // ignore: invalid_use_of_protected_member
    if (mounted) {
      setState(() {
        _isBackIconShow = !isHiinde;
      });
    }
  }

  ///返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  ///点击错误页面后展示内容
  void onClickErrorWidget() {}

  Widget getLoadingWidget() {
    return Container(
      //错误页面中心可以自己调整
      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
      color: Colors.black12,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child:
            // 圆形进度条
            new CircularProgressIndicator(
          strokeWidth: 4.0,
          backgroundColor: Colors.blue,
          // value: 0.2,
          valueColor: new AlwaysStoppedAnimation<Color>(_appBarColor),
        ),
      ),
    );
  }

  ///导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarCenter() {
    return Text(
      _appBarTitle,
      style: TextStyle(
        fontSize: _appBarCenterTextSize,
        color: _appBarContentColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ///导航栏appBar中间部分 ，不满足可以自行重写
  Widget getAppBarRight() {
    return Text(
      _appBarRightTitle == null ? "" : _appBarRightTitle,
      style: TextStyle(
        fontSize: _appBarRightTextSize,
        color: _appBarContentColor,
      ),
    );
  }

  ///导航栏appBar左边部分 ，不满足可以自行重写
  Widget getAppBarLeft() {
    return InkWell(
      onTap: clickAppBarBack,
      child: Icon(
        Icons.arrow_back,
        color: _appBarContentColor,
      ),
    );
  }

  void clickAppBarBack() {

  }

  void retryClick() {
  }
}
