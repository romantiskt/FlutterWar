package com.jtjr99.jiayoubao

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.jtjr99.jiayoubao.ui.main.MainFragment
import com.jtjr99.jiayoubao.util.StatusBarUtil

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        StatusBarUtil.setTransparentForWindow(this)
        StatusBarUtil.setDarkMode(this)
        setContentView(R.layout.main_activity)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                    .replace(R.id.container, MainFragment.newInstance())
                    .commitNow()
        }
    }
}
