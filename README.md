# FlutterWar


## ios工程引入
实现我们已经创建了flutter module。我们下面的操作是把flutter加入到已有ios工程里

1.在ios工程目录下生成podfile文件
```
pod init

```

2.在podfile文件中加入下面
```
flutter_application_path = '../my_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
```
下面附上完整文件内容

```
platform :ios, '10.0'


flutter_application_path = '../flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'Imitate' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
    # Pods for Imitate
  install_all_flutter_pods(flutter_application_path)

  target 'ImitateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ImitateUITests' do
    # Pods for testing
  end

end
```

3.运行pod install

```
Analyzing dependencies
Downloading dependencies
Installing Flutter (1.0.0)
Installing FlutterPluginRegistrant (0.0.1)
Installing fluttermodule (0.0.1)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `Imitate.xcworkspace` for this project from now on.
Pod installation complete! There are 3 dependencies from the Podfile and 3 total pods installed.

pod install 
生成 xx.xcworkspace文件，然后xcode打开这个文件 
```

4.打开xx.xcworkspace文件，然后开始flutter入口配置。

下面关于flutter的代码如果报错，记得引入相关包
编辑AppDelegate.h文件
```
@import UIKit;
@import Flutter;

@interface AppDelegate : FlutterAppDelegate // More on the FlutterAppDelegate below.
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
```
编辑AppDelegate.m
```
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
  self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
  // Runs the default Dart entrypoint with a default Flutter route.
  [self.flutterEngine run];
  // Used to connect plugins (only if you have plugins with iOS platform code).
  [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

然后在某一个页面配置入口

```
@import Flutter;
#import "AppDelegate.h"
#import "ViewController.h"

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

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
    FlutterEngine *flutterEngine =
        ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}
@end
```