//
//  IMTabBar.m
//  Imitate
//
//  Created by 王阳 on 2018/11/20.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "IMTabBar.h"
#import "IMTabButton.h"
@interface IMTabBar()
@property(nonatomic,strong)UIButton* lastButton;
@end
@implementation IMTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setItems:(NSArray *)items{
    _items=items;
    int i=0;
    for(UITabBarItem* item in items){
        IMTabButton* button= [IMTabButton buttonWithType:UIButtonTypeCustom];
        button.tag=i;
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:item.selectedImage forState:UIControlStateSelected];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitleColor:getColor.h2 forState:UIControlStateNormal];
        [button setTitleColor: getColor.main forState:UIControlStateSelected];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        button.backgroundColor=[UIColor whiteColor];
       
        UIImage *buttonImg = [button imageForState:UIControlStateNormal];
        CGFloat titleWidth = [button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18],NSFontAttributeName, nil]].width;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(buttonImg.size.height-5, -buttonImg.size.width, 0, 0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -titleWidth/2-5)];
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
        if(i==0){
            [self btnClick:button];
        }
         i++;
       
    }
}

-(void)btnClick:(UIButton*)btn{
    _lastButton.selected=NO;
    btn.selected=YES;
    _lastButton=btn;
    if([_delegate respondsToSelector:@selector(tabBar:click:)]){
        [_delegate tabBar:self click:btn.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)_items.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    
    // 设置按钮的位置
    for (int i = 0; i < count; i++) {
        UIButton *btn =  self.subviews[i];
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}
@end
