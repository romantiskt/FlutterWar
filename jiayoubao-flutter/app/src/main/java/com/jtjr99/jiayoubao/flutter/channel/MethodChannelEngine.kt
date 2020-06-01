package com.jtjr99.jiayoubao.flutter.channel

import io.flutter.embedding.engine.FlutterEngine

/**
 * Created by wangyang on 2020/6/1.17:45
 */
class MethodChannelEngine(private val engine: FlutterEngine) {

    fun init(){
        LogMethodChannel(engine)
        NetMethodChannel(engine)
    }
}