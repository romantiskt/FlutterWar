//
//  AppDelegate.m
//  Imitate
//
//  Created by 王阳 on 2018/11/20.
//  Copyright © 2018年 王阳. All rights reserved.
//

#import "AppDelegate.h"
#import "IMTabBarController.h"
#import "GeneratedPluginRegistrant.h"
#import "RegisterApi.h"
#import <Foundation/Foundation.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    IMTabBarController* tabBarController=[[IMTabBarController alloc] init];
    tabBarController.view.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=tabBarController;
    [self.window makeKeyAndVisible];
    
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
    // Runs the default Dart entrypoint with a default Flutter route.
    [self.flutterEngine run];
    
    FlutterMethodChannel* netWorkChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"native_network"
                                            binaryMessenger:self.flutterEngine.binaryMessenger];
    [netWorkChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"get" isEqualToString:call.method]) {
            NSDictionary *args = call.arguments;
            RegisterApi *api = [[RegisterApi alloc] initWithUrl:args[@"url"] ];
                   [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                       NSLog(@"succeed");
                       result(request.responseString);
                   } failure:^(YTKBaseRequest *request) {
                       // 你可以直接在这里使用 self
                       NSLog(@"failed");
                       result([FlutterError errorWithCode:@"UNAVAILABLE"
                                                       message:@"请求错误"
                                                       details:nil]);
                   }];
        }
    }];
    
    FlutterMethodChannel* logChannel=[FlutterMethodChannel methodChannelWithName:@"native_log" binaryMessenger:self.flutterEngine.binaryMessenger];
    [logChannel setMethodCallHandler:^(FlutterMethodCall *  call, FlutterResult   result) {
        NSDictionary *args = call.arguments;
        NSString* tag=args[@"tag"];
        NSString* msg=args[@"msg"];
        if ([@"logD" isEqualToString:call.method]) {
            NSLog(@"debug tag:%@  msg:%@",tag,msg);
        }else{
             NSLog(@"normal tag:%@  msg:%@",tag,msg);
        }
    }];
    
    // Used to connect plugins (only if you have plugins with iOS platform code).
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
