package com.jtjr99.jiayoubao

import android.app.Application
import com.jtjr99.jiayoubao.flutter.channel.MethodChannelEngine
import com.lzy.okgo.OkGo
import com.lzy.okgo.cache.CacheMode
import com.lzy.okgo.interceptor.HttpLoggingInterceptor
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import okhttp3.OkHttpClient
import java.util.concurrent.TimeUnit
import java.util.logging.Level


/**
 * Created by wangyang on 2020/5/27.16:13
 */
class App : Application() {
    lateinit var flutterEngine: FlutterEngine


    /**
     * 这里有坑，如果用缓存engine,则应在此处初始化MethodChannel,
     * 而不是FlutterActivity中的configureFlutterEngine方法
     */
    override fun onCreate() {
        super.onCreate()
        initHttp()
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        flutterEngine.navigationChannel.setInitialRoute("/")
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        initMethodChannel()
    }

    private fun initHttp() {
        val builder = OkHttpClient.Builder()
        val loggingInterceptor = HttpLoggingInterceptor("OkGo")
        loggingInterceptor.setPrintLevel(HttpLoggingInterceptor.Level.BODY)
        loggingInterceptor.setColorLevel(Level.INFO)
        builder.addInterceptor(loggingInterceptor)
        builder.readTimeout(10000, TimeUnit.MILLISECONDS)
        builder.writeTimeout(10000, TimeUnit.MILLISECONDS)
        builder.connectTimeout(10000, TimeUnit.MILLISECONDS)
        OkGo.getInstance().init(this)
            .setOkHttpClient(builder.build()).cacheMode = CacheMode.NO_CACHE
    }

    private fun initMethodChannel() {
        MethodChannelEngine(flutterEngine).init()
    }
}