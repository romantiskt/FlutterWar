package com.jtjr99.jiayoubao.widget.tab

import android.content.Context
import android.os.Parcelable
import android.util.AttributeSet
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.jtjr99.jiayoubao.R
import com.jtjr99.jiayoubao.util.DensityUtil.dip2px
import java.util.*

/**
 * Created by wangyang on 2018/9/30.下午4:27
 */
class BottomTabBar : LinearLayout, View.OnClickListener {
    private var widthXML = -1
    private var heightXML = -1
    private val tabDataList: MutableList<TabEntity> =
        ArrayList()
    private val tabViewList: MutableList<View> =
        ArrayList()
    private var selectIndex = -1
    private var mContext: Context
    private var tabSelectedListener: TabSelectedListener? = null
    private var normalColor = 0
    private var selectColor = 0

    constructor(context: Context) : super(context) {
        mContext = context
    }

    @JvmOverloads
    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyleAttr: Int = 0
    ) : super(context, attrs, defStyleAttr) {
        mContext = context
        val a = context.obtainStyledAttributes(
            attrs,
            R.styleable.bottomBar,
            defStyleAttr,
            0
        )
        widthXML = a.getLayoutDimension(
            R.styleable.bottomBar_android_layout_width,
            -1
        ) //默认match_parent
        heightXML = a.getLayoutDimension(
            R.styleable.bottomBar_android_layout_height,
            dip2px(50f)
        ) //默认50dp
        setBackgroundResource(R.color.white)
        orientation = HORIZONTAL
    }

    fun addTab(
        title: String?,
        normalIcon: Int,
        selectIcon: Int,
        selected: Boolean
    ): BottomTabBar {
        val entity = addTabsData(
            TabEntity.TabBuilder()
                .create(title, normalIcon, selectIcon, selected).build()
        )
        addTabsView(entity)
        return this
    }

    fun init(normalColor: Int, selectColor: Int): BottomTabBar {
        this.normalColor = normalColor
        this.selectColor = selectColor
        return this
    }

    /**
     * 复杂属性的tab
     *
     * @param tab
     * @return
     */
    fun addTab(tab: TabEntity?): BottomTabBar {
        if (tab == null) {
            throw NullPointerException("TabEntity is can't null")
        }
        val entity = addTabsData(tab)
        addTabsView(entity)
        return this
    }

    fun addSelectListener(listener: TabSelectedListener?): BottomTabBar {
        tabSelectedListener = listener
        return this
    }

    private fun addTabsData(entity: TabEntity): TabEntity {
        val selected = entity.isSelected
        entity.index = tabDataList.size
        if (selectIndex == -1 && selected) { //初始化的时候默认只有第一次设置select有效
            selectIndex = tabDataList.size
            entity.isSelected = selected
        } else {
            entity.isSelected = false
        }
        tabDataList.add(entity)
        return entity
    }

    private fun addTabsView(entity: TabEntity) {
        val tabView =
            View.inflate(mContext, R.layout.item_tab, null)
        val textView =
            tabView.findViewById<TextView>(R.id.txt)
        val mark =
            tabView.findViewById<TextView>(R.id.iv_mark)
        val imageView =
            tabView.findViewById<ImageView>(R.id.img)
        textView.text = entity.title
        normalColor =
            if (normalColor != 0) normalColor else if (entity.normalColor != 0) entity.normalColor else R.color.font_color_b2
        selectColor =
            if (selectColor != 0) selectColor else if (entity.selectColor != 0) entity.selectColor else R.color.colorPrimary
        if (entity.isSelected) {
            textView.setTextColor(resources.getColor(selectColor))
            imageView.setImageResource(entity.selectIcon)
        } else {
            textView.setTextColor(resources.getColor(normalColor))
            imageView.setImageResource(entity.normalIcon)
        }
        mark.visibility = if (entity.unReadNum > 0) View.VISIBLE else View.GONE
        val layoutParams =
            LayoutParams(0, heightXML, 1.0f)
        tabView.layoutParams = layoutParams
        tabView.setOnClickListener(this)
        tabView.tag = entity.index
        tabViewList.add(tabView)
        addView(tabView)
    }

    fun refreshRedPoint(index: Int, unReadNum: Int) {
        val entity = tabDataList[index]
        val view = tabViewList[index]
        val textView =
            view.findViewById<TextView>(R.id.txt)
        val mark =
            view.findViewById<TextView>(R.id.iv_mark)
        val imageView =
            view.findViewById<ImageView>(R.id.img)
        entity.unReadNum = unReadNum
        mark.visibility = if (entity.unReadNum > 0) View.VISIBLE else View.GONE
    }

    override fun onClick(v: View) {
        val index = v.tag as Int
        switchTab(index)
    }

    /**
     * 第一次基于selectIndex主动回调一次选择
     */
    fun initSelectListener() {
        if (selectIndex != -1 && selectIndex < tabViewList.size) {
            switchTab(selectIndex, true)
        }
    }

    /**
     * 切换至某个指定tab，
     *
     * @param index
     * @param init  是否初始化的切换
     */
    @JvmOverloads
    fun switchTab(index: Int, init: Boolean = false) {
        if (index == selectIndex && !init) return
        for (i in tabDataList.indices) {
            setItemStatus(i, false)
        }
        setItemStatus(index, true)
        selectIndex = index
        if (tabSelectedListener != null) {
            tabSelectedListener!!.select(selectIndex)
        }
    }

    private fun setItemStatus(index: Int, select: Boolean) {
        val entity = tabDataList[index]
        val view = tabViewList[index]
        val textView =
            view.findViewById<TextView>(R.id.txt)
        val mark =
            view.findViewById<TextView>(R.id.iv_mark)
        val imageView =
            view.findViewById<ImageView>(R.id.img)
        mark.visibility = if (entity.unReadNum > 0) View.VISIBLE else View.GONE
        normalColor =
            if (normalColor != 0) normalColor else if (entity.normalColor != 0) entity.normalColor else R.color.font_color_b2
        selectColor =
            if (selectColor != 0) selectColor else if (entity.selectColor != 0) entity.selectColor else R.color.colorPrimary
        if (select) {
            textView.setTextColor(resources.getColor(selectColor))
            imageView.setImageResource(entity.selectIcon)
        } else {
            textView.setTextColor(resources.getColor(normalColor))
            imageView.setImageResource(entity.normalIcon)
        }
    }

    override fun onSaveInstanceState(): Parcelable? {
        val superState = super.onSaveInstanceState()
        val ss = BottomSavedState(superState)
        ss.width = widthXML
        ss.height = heightXML
        ss.selectIndex = selectIndex
        return ss
    }

    override fun onRestoreInstanceState(state: Parcelable) {
        if (state !is BottomSavedState) {
            super.onRestoreInstanceState(state)
            return
        }
        val ss = state
        super.onRestoreInstanceState(ss.superState)
        widthXML = ss.width
        heightXML = ss.height
        switchTab(ss.selectIndex, false)
    }
}