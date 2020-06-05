//
//  IMNavigationViewController.m
//  Imitate
//
//  Created by 王阳 on 2018/11/20.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "IMNavigationViewController.h"

@interface IMNavigationViewController ()

@end

@implementation IMNavigationViewController
+ (void)initialize{
    if(self==[IMNavigationViewController class]){
        UINavigationBar* navBar=[UINavigationBar appearanceWhenContainedIn:self, nil];
//        [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
        NSMutableDictionary* textAttr=[NSMutableDictionary dictionary];
        textAttr[NSForegroundColorAttributeName]=[UIColor blackColor];
        textAttr[NSFontAttributeName]=[UIFont boldSystemFontOfSize:18];
        navBar.backgroundColor=[UIColor whiteColor];
        navBar.titleTextAttributes=textAttr;
        
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
