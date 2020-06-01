package com.jtjr99.jiayoubao.widget.tab

import android.os.Parcel
import android.os.Parcelable
import android.view.View

/**
 * Created by wangyang on 2018/10/8.下午4:01
 */
class BottomSavedState : View.BaseSavedState {
    @JvmField
    var width = 0
    @JvmField
    var height = 0
    @JvmField
    var selectIndex = 0

    internal constructor(superState: Parcelable?) : super(superState) {}
    private constructor(`in`: Parcel) : super(`in`) {
        width = `in`.readInt()
        height = `in`.readInt()
        selectIndex = `in`.readInt()
    }

    override fun writeToParcel(out: Parcel, flags: Int) {
        super.writeToParcel(out, flags)
        out.writeInt(width)
        out.writeInt(height)
        out.writeInt(selectIndex)
    }

    companion object {
        val CREATOR: Parcelable.Creator<BottomSavedState> =
            object : Parcelable.Creator<BottomSavedState> {
                override fun createFromParcel(`in`: Parcel): BottomSavedState? {
                    return BottomSavedState(`in`)
                }

                override fun newArray(size: Int): Array<BottomSavedState?> {
                    return arrayOfNulls(size)
                }
            }
    }
}