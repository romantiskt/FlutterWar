//
//  IMColor.h
//  Imitate
//
//  Created by 王阳 on 2018/11/21.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define JT_COLOR_ALPHA(r,g,b,a)   ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define JT_COLOR(r,g,b)           JT_COLOR_ALPHA(r,g,b,1.0)
#define JT_COLOR_HEX_ALPHA(h,a)   JT_COLOR_ALPHA(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)
#define JT_COLOR_HEX(h)           JT_COLOR_HEX_ALPHA(h, 1.0)
@interface IMColor : NSObject

@property (readonly, nonatomic , strong) UIColor *main;                     // 0xff6e34
/** 一级文字  */
@property (readonly, nonatomic , strong) UIColor *h1;                       // 0x333333
/** 二级文字  */
@property (readonly, nonatomic , strong) UIColor *h2;                       // 0x999999

@end
