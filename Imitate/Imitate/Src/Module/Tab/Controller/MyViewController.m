//
//  MyViewController.m
//  Imitate
//
//  Created by 王阳 on 2018/11/21.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "MyViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Make a button to call the showFlutter function when pressed.
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       [button addTarget:self
                  action:@selector(showFlutter)
        forControlEvents:UIControlEventTouchUpInside];
       [button setTitle:@"Show Flutter!" forState:UIControlStateNormal];
       button.backgroundColor = UIColor.blueColor;
       button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
       [self.view addSubview:button];
}

- (void)showFlutter {
  FlutterEngine *flutterEngine =((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
      FlutterViewController *flutterViewController =
          [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
      [self presentViewController:flutterViewController animated:YES completion:nil];
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
