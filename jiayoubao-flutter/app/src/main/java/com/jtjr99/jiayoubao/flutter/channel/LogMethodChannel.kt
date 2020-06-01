package com.jtjr99.jiayoubao.flutter.channel

import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Created by wangyang on 2020/6/1.17:43
 */
class LogMethodChannel(flutterEngine: FlutterEngine) : MethodChannel.MethodCallHandler {
    private val CHANNEL_LOG = "native_log"

    init {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_LOG
        ).setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        var tag: String = call.argument("tag") ?: "flutter"
        var message: String = call.argument("msg") ?: ""
        when (call.method) {
            "logV" -> Log.v(tag, message)
            "logD" -> Log.d(tag, message)
            "logI" -> Log.i(tag, message)
            "logW" -> Log.w(tag, message)
            "logE" -> Log.e(tag, message)
        }
        result.success("success");
    }
}