//
//  IMTabBarController.m
//  Imitate
//
//  Created by 王阳 on 2018/11/20.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "IMTabBarController.h"
#import "IMNavigationViewController.h"
#import "IMTabBar.h"
#import "HomeViewController.h"
#import "InverstmentViewController.h"
#import "StoreViewController.h"
#import "MyViewController.h"

@interface IMTabBarController ()<IMTabBarClickDelegate>
@property(nonatomic,strong)NSMutableArray* items;
@end

@implementation IMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self initTabBar];
    
}

-(void)initTabBar{
    NSLog(@"数组大小：%@",self.tabBar);
//    [self.tabBar removeFromSuperview];
    IMTabBar* tabBar=[[IMTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.delegate=self;
    tabBar.items=self.items;
    
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor =[UIColor whiteColor];
    [self.tabBar insertSubview:tabBar atIndex:0];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除系统UITabBar上自带的按钮
    for (UIView *childView in self.tabBar.subviews) {
        // 判断下是否是UITabButton
        if ([childView isKindOfClass:[IMTabBar class]] == NO) {
            
            [childView setHidden:true];
        }
    }
}
- (void)tabBar:(IMTabBar *)tabBar click:(NSInteger)buttonIndex
{
    self.selectedIndex = buttonIndex;
}

-(void)initViewController{
    UIViewController* homeViewController=[[HomeViewController alloc]init];
    [self addChildViewToRoot:homeViewController normalImage:[UIImage imageNamed:@"tabbar-item1-icon-normal"] selectImage:[UIImage imageNamed:@"tabbar-item1-icon-selected"] title:@"首页"];
    
     UIViewController* inversmentController=[[InverstmentViewController alloc]init];
    [self addChildViewToRoot:inversmentController normalImage:[UIImage imageNamed:@"tabbar-item2-icon-normal"] selectImage:[UIImage imageNamed:@"tabbar-item2-icon-selected"] title:@"理财"];
    
    UIViewController* storeViewController=[[StoreViewController alloc]init];
    [self addChildViewToRoot:storeViewController normalImage:[UIImage imageNamed:@"tabbar-item3-icon-normal"] selectImage:[UIImage imageNamed:@"tabbar-item3-icon-selected"] title:@"商城"];
    
    UIViewController* myViewController=[[MyViewController alloc]init];
    [self addChildViewToRoot:myViewController normalImage:[UIImage imageNamed:@"tabbar-item4-icon-normal"] selectImage:[UIImage imageNamed:@"tabbar-item4-icon-selected"] title:@"我的"];
    
 
}
-(void) addChildViewToRoot:(UIViewController*)vc normalImage:(UIImage*) imageNormal selectImage:(UIImage*) imageSelect title:(NSString*)title{
    vc.navigationItem.title=title;
    IMNavigationViewController* nav=[[IMNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image=imageNormal;
    nav.tabBarItem.selectedImage=imageSelect;
    nav.tabBarItem.title=title;
    [self.items addObject:nav.tabBarItem];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)items{
    if(_items==nil){
        _items=[NSMutableArray array];
    }
    return _items;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
