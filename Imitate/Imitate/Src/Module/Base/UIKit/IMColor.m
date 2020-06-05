//
//  IMColor.m
//  Imitate
//
//  Created by 王阳 on 2018/11/21.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "IMColor.h"

@implementation IMColor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _main = JT_COLOR_HEX(0xff6e34);
        _h1 = JT_COLOR_HEX(0x333333);
        _h2 = JT_COLOR_HEX(0x999999);
    }
    return self;
}

- (UIColor *)colorWithValue:(long long)value {
    return JT_COLOR_HEX(value);
}

@end
