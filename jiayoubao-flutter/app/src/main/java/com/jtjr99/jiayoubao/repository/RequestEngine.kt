package com.jtjr99.jiayoubao.repository

import com.lzy.okgo.OkGo
import com.lzy.okgo.callback.Callback
import com.lzy.okgo.callback.StringCallback
import com.lzy.okgo.model.Progress
import com.lzy.okgo.request.base.Request
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.Response

/**
 * Created by wangyang on 2020/6/1.17:55
 */
object RequestEngine {

   suspend fun get(url:String): Response = withContext(Dispatchers.IO){
        OkGo.get<String>(url).execute()
   }
}