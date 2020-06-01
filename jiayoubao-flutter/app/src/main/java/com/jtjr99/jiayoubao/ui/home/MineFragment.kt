package com.jtjr99.jiayoubao.ui.home

import android.content.Intent
import com.jtjr99.jiayoubao.BR
import com.jtjr99.jiayoubao.R
import com.jtjr99.jiayoubao.base.BaseFragment
import com.jtjr99.jiayoubao.flutter.MyFlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs

/**
 * Created by wangyang on 2020/5/26.21:23
 */
class MineFragment : BaseFragment() {

    override fun initView() {
        binding.setVariable(BR.click, ClickPresenter())
    }

    override fun layoutId(): Int {
        return R.layout.mine_fragment
    }

    public fun enterFlutter() {
        var intent = Intent(context, MyFlutterActivity::class.java)
        intent.putExtra("cached_engine_id", "my_engine_id")
        intent.putExtra("background_mode", FlutterActivityLaunchConfigs.BackgroundMode.transparent.name)
        startActivity(intent)
    }


    inner class ClickPresenter {

        fun clickFlutter() {
            enterFlutter()
        }
    }

}