package com.jtjr99.jiayoubao.flutter.channel

import android.util.Log
import com.jtjr99.jiayoubao.repository.RequestEngine
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import okhttp3.Response

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
        if (call.method == "get") {
            GlobalScope.launch(Dispatchers.Main) {
                if (call.arguments is HashMap<*, *>) {
                    val arguments = call.arguments as? HashMap<*, *>
                    if (arguments != null && arguments.isNotEmpty()) {
                        val url = arguments["url"]
                        if (url != null && url is String && url.isNotEmpty()) {
                            val response = try {
                                RequestEngine.get(url)
                            } catch (e: Exception) {
                            }
                            if(response is Response){
                                val body = response.body()
                                if (body != null) {
                                    result.success(body.string())
                                } else {
                                    result.error("error", "请求网络出错误了,body is null", null) // 告诉调用者失败了
                                }
                            }else if(response is java.lang.Exception){
                                result.error("error", response.message, null) // 告诉调用者失败了
                            }else{
                                result.error("error", "网络开小差了，请稍后再试", null) // 告诉调用者失败了
                            }

                            return@launch
                        }
                    }
                }

                result.error("error", "请求参数非法", null) // 告诉调用者失败了

            }

        } else {
            result.notImplemented() // 告诉调用者没有此方法，避免一直等到阻塞在这
        }
    }
}