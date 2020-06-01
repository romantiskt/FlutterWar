package com.jtjr99.jiayoubao.flutter.channel

import com.jtjr99.jiayoubao.repository.RequestEngine
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

/**
 * Created by wangyang on 2020/6/1.17:39
 */
class NetMethodChannel(flutterEngine: FlutterEngine) : MethodChannel.MethodCallHandler {
    private val CHANNEL_NETWORK = "native_network"

    init {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NETWORK
        ).setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "test") {
            val batteryLevel: String = "hello kotlin"
            if (batteryLevel != null) {
                result.success(batteryLevel) // 相当于是调用方法的return
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null) // 告诉调用者失败了
            }
        } else if (call.method == "get") {
            GlobalScope.launch(Dispatchers.Main) {
                val response = RequestEngine.get("https://www.fastmock.site/mock/596f8699defc6f723bd948351260e0a7/flutter/page/my")
                val body = response.body()
                if (body != null) {
                    result.success(body.string())
                } else {
                    result.error("error", "请求网络出错误了", null) // 告诉调用者失败了
                }
            }

        } else {
            result.notImplemented() // 告诉调用者没有此方法，避免一直等到阻塞在这
        }
    }
}