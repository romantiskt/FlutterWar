//
//  AppResouce.m
//  Imitate
//
//  Created by 王阳 on 2018/11/21.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "AppResouce.h"

@implementation AppResouce

+ (instancetype)sharedInstance{
    static id sharedInstance;
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[AppResouce alloc] init];
        }
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _color= [[IMColor alloc] init];
    }
    
    return self;
}
@end
