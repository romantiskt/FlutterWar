//
//  AppResouce.h
//  Imitate
//
//  Created by 王阳 on 2018/11/21.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMColor.h"
@interface AppResouce : NSObject


@property (readonly, nonatomic , strong) IMColor  * color;

+ (instancetype)sharedInstance;
@end
