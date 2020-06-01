package com.jtjr99.jiayoubao.ui.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.jtjr99.jiayoubao.R

/**
 * Created by wangyang on 2020/5/26.21:26
 */
class InvestFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View {
        return inflater.inflate(R.layout.invest_fragment, container, false)
    }
}