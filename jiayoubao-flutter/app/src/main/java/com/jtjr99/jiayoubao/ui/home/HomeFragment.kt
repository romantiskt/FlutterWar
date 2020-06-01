package com.jtjr99.jiayoubao.ui.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.jtjr99.jiayoubao.R

/**
 * Created by wangyang on 2020/5/26.20:17
 */
class HomeFragment:Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View {
        return inflater.inflate(R.layout.home_fragment, container, false)
    }
}