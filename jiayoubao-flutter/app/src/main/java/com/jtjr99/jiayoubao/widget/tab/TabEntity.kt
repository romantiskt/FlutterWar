package com.jtjr99.jiayoubao.widget.tab

import java.util.*

/**
 * Created by wangyang on 2018/10/8.下午2:45
 */
class TabEntity {
    var title: String? = null
    var normalIcon = 0
    var selectIcon = 0
    var index = 0
    var isSelected = false
    var selectColor = 0
    var normalColor = 0
    var unReadNum //未读消息的数目
            = 0

    class TabBuilder {
        private var title: String? = null
        private var normalIcon = 0
        private var selectIcon = 0
        private val index = 0
        private var selected = false
        private var tags: HashMap<*, *>? = null
        private var selectColor = 0
        private var normalColor = 0
        fun create(
            title: String?,
            normalIcon: Int,
            selectIcon: Int,
            selected: Boolean
        ): TabBuilder {
            this.title = title
            this.normalIcon = normalIcon
            this.selectIcon = selectIcon
            this.selected = selected
            return this
        }

        fun tabColor(
            normalColor: Int,
            selectColor: Int
        ): TabBuilder {
            this.selectColor = selectColor
            this.normalColor = normalColor
            return this
        }

        fun build(): TabEntity {
            val entity = TabEntity()
            entity.title = title
            entity.normalIcon = normalIcon
            entity.selectIcon = selectIcon
            entity.isSelected = selected
            entity.selectColor = selectColor
            entity.normalColor = normalColor
            return entity
        }
    }
}