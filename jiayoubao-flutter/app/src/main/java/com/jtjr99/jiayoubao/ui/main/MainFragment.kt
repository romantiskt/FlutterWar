package com.jtjr99.jiayoubao.ui.main

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import androidx.viewpager2.widget.ViewPager2
import butterknife.BindView
import com.jtjr99.jiayoubao.R
import com.jtjr99.jiayoubao.base.BaseFragment
import com.jtjr99.jiayoubao.ext.init
import com.jtjr99.jiayoubao.ui.home.HomeFragment
import com.jtjr99.jiayoubao.ui.home.InvestFragment
import com.jtjr99.jiayoubao.ui.home.MineFragment
import com.jtjr99.jiayoubao.ui.home.StoreFragment
import com.jtjr99.jiayoubao.widget.tab.BottomTabBar
import com.jtjr99.jiayoubao.widget.tab.TabEntity
import com.jtjr99.jiayoubao.widget.tab.TabSelectedListener
import kotlinx.android.synthetic.main.main_fragment.*

class MainFragment : BaseFragment() {

    @BindView(R.id.main_viewpager)
    lateinit var viewPager: ViewPager2

    @BindView(R.id.bottom_tab)
    lateinit var tab: BottomTabBar

    var fragments = arrayListOf<Fragment>()
    private val homeFragment: HomeFragment by lazy { HomeFragment() }
    private val investFragment: InvestFragment by lazy { InvestFragment() }
    private val storeFragment: StoreFragment by lazy { StoreFragment() }
    private val mineFragment: MineFragment by lazy { MineFragment() }

    init {
        fragments.apply {
            add(homeFragment)
            add(investFragment)
            add(storeFragment)
            add(mineFragment)
        }
    }

    companion object {
        fun newInstance() = MainFragment()
    }

    private lateinit var viewModel: MainViewModel
    override fun initView() {
        viewPager.init(this, fragments, false).run {
            offscreenPageLimit = fragments.size
        }
        val textArray = resources.getStringArray(R.array.main_tab)
        tab
            .addTab(
                TabEntity.TabBuilder()
                    .create(
                        textArray[0],
                        R.mipmap.ic_tab_index_normal,
                        R.mipmap.ic_tab_index_selected,
                        true
                    ).build()
            )
            .addTab(
                TabEntity.TabBuilder()
                    .create(
                        textArray[1],
                        R.mipmap.ic_tab_product_normal,
                        R.mipmap.ic_tab_product_selected,
                        false
                    ).build()
            )
            .addTab(
                TabEntity.TabBuilder()
                    .create(
                        textArray[2],
                        R.mipmap.ic_tab_shop_normal,
                        R.mipmap.ic_tab_shop_selected,
                        false
                    ).build()
            )
            .addTab(
                TabEntity.TabBuilder()
                    .create(
                        textArray[3],
                        R.mipmap.ic_tab_mine_normal,
                        R.mipmap.ic_tab_mine_selected,
                        false
                    ).build()
            )
            .addSelectListener(object : TabSelectedListener {
                override fun select(index: Int) {
                    viewPager.setCurrentItem(index, false)
                }

            })
        tab.initSelectListener()
    }

    override fun layoutId(): Int {
        return R.layout.main_fragment
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)
        // TODO: Use the ViewModel
    }

}
