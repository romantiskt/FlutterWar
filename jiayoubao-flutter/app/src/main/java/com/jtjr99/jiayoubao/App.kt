package com.jtjr99.jiayoubao

import android.app.Application
import android.util.Log
import com.jtjr99.jiayoubao.flutter.channel.MethodChannelEngine
import com.lzy.okgo.OkGo
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

/**
 * Created by wangyang on 2020/5/27.16:13
 */
class App:Application() {
     lateinit var flutterEngine : FlutterEngine


    /**
     * 这里有坑，如果用缓存engine,则应在此处初始化MethodChannel,
     * 而不是FlutterActivity中的configureFlutterEngine方法
     */
    override fun onCreate() {
        super.onCreate()
        OkGo.getInstance().init(this);
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        initMethodChannel()
    }

    private fun initMethodChannel() {
        MethodChannelEngine(flutterEngine).init()
    }
}