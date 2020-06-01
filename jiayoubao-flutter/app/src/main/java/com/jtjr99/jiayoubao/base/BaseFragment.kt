package com.jtjr99.jiayoubao.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import butterknife.ButterKnife

/**
 * Created by wangyang on 2020/5/27.10:18
 */
abstract class BaseFragment : Fragment() {
    lateinit var binding: ViewDataBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, layoutId(), container, false)
        binding.lifecycleOwner = this
        ButterKnife.bind(this,binding.root)
        initView()
        return binding.root
    }

    abstract fun initView()

    abstract fun layoutId(): Int
}