//
//  AppDelegate.m
//  mscare
//
//  Created by MissionHealth on 15/8/25.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "SNLoginVC.h"
#import "IQKeyboardManager.h"
#import "Reachability.h"
#import "SNAboutVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    SNLoginVC *rootVC = [[SNLoginVC alloc] init];
    SlideNavigationController *vc = [[SlideNavigationController alloc] initWithRootViewController:rootVC];
    vc.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // 配置侧滑
    [self configSlideNavigationController];
    // 配置键盘
    [self configIQKeyBoardManager];
    // 配置HUD
    [self configSVHUD];
    // 注册网络通知
    [self configReachability];
    
    return YES;
}

#pragma mark - 配置侧滑
- (void)configSlideNavigationController
{
    SNAboutVC *leftMenu = [SNAboutVC shareInstance];
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].enableShadow = YES;
    // 设置导航栏默认颜色(全局属性)
    [[SlideNavigationController sharedInstance].navigationBar configureNavigationBarBackgroundColor:ZZNavColor];
}

#pragma mark - 配置键盘样式
- (void)configIQKeyBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldShowTextFieldPlaceholder = YES;
    manager.toolbarManageBehaviour = IQAutoToolbarByPosition;
}

#pragma mark - 配置HUD
- (void)configSVHUD
{
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

#pragma mark - 注册网络状态通知
- (void)configReachability
{
    // 使用百度测试网络是否正常
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *reach = [note object];
    
    NetworkStatus status = [reach currentReachabilityStatus];
    NSLog(@"reachabilityChanged: %d", (int)status);
    
    memberShare.currentNetworkStatus = status;
}


@end
