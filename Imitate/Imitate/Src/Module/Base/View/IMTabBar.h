//
//  IMTabBar.h
//  Imitate
//
//  Created by 王阳 on 2018/11/20.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMTabBar;
@protocol IMTabBarClickDelegate<NSObject>

@optional
- (void)tabBar:(IMTabBar *)tabBar click:(NSInteger)buttonIndex;
@end

@interface IMTabBar : UIView
@property(nonatomic,weak)id<IMTabBarClickDelegate> delegate;
@property(nonatomic,strong)NSArray* items;
@end
