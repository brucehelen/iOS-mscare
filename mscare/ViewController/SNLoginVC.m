//
//  SNLoginVC.m
//  SHHI
//
//  Created by 朱正晶 on 15/7/21.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import "SNLoginVC.h"
#import "SVProgressHUD.h"
#import "SDImageCache.h"
#import "BZIconTextFieldView.h"
#import "M13Checkbox.h"

#import "MCFirstMainVC.h"
#import "MCSecondMainVC.h"
#import "MCThirdMainVC.h"

#import "AppDelegate.h"

#import "BaseNavigationController.h"

#define kEdgeOffset     20


@interface SNLoginVC ()

@property (nonatomic, strong) UITabBarController *mainTabBarVC;

@end

@implementation SNLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configView];
    [self jumpMainVC];
}

- (void)configView
{
    self.view.backgroundColor = RGBA(10, 10, 13, 1);

    // 开源大赛背景
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"ickey_start"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.5);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.4);
    }];
    
    // 项目名称
    UILabel *projectLabel = [UILabel new];
    projectLabel.text = @"参赛作品";
    projectLabel.font = [UIFont boldSystemFontOfSize:22];
    projectLabel.textAlignment = NSTextAlignmentCenter;
    projectLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:projectLabel];
    [projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = RGBA(79, 218, 85, 1);
    nameLabel.text = @"智慧家庭(Smart Home)";
    nameLabel.font = [UIFont boldSystemFontOfSize:27];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(projectLabel);
        make.top.equalTo(projectLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    UILabel *authorLabel = [UILabel new];
    authorLabel.textColor = RGBA(11, 111, 225, 1);
    authorLabel.text = @"ID: 小麦克\nQQ: 378214384";
    authorLabel.numberOfLines = 0;
    authorLabel.font = [UIFont systemFontOfSize:18];
    authorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:authorLabel];
    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(projectLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

- (void)jumpMainVC
{
    WS(ws);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       [AppDelegate mainDelegate].slideMenuVC.mainViewController = ws.mainTabBarVC;
                   });
}

- (UITabBarController *)mainTabBarVC
{
    if (_mainTabBarVC == nil) {
        [self configViewControllers];
    }

    return _mainTabBarVC;
}

- (void)configViewControllers
{
    _mainTabBarVC = [[UITabBarController alloc] init];
    _mainTabBarVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);

    MCFirstMainVC *vc1 = [[MCFirstMainVC alloc] init];
    vc1.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:vc1];

    MCSecondMainVC *vc2 = [[MCSecondMainVC alloc] init];
    vc2.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    BaseNavigationController *secondNav = [[BaseNavigationController alloc] initWithRootViewController:vc2];

    MCThirdMainVC *vc3 = [[MCThirdMainVC alloc] init];
    vc3.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    BaseNavigationController *thirdNav = [[BaseNavigationController alloc] initWithRootViewController:vc3];

    _mainTabBarVC.viewControllers = @[firstNav, secondNav, thirdNav];

    NSArray *imageArray = @[@"ico_tabbar_home",
                            @"ico_tabbar_my",
                            @"ico_tabbar_more"];
    NSArray *selectedArray = @[@"ico_tabbar_home_selected",
                               @"ico_tabbar_my_selected",
                               @"ico_tabbar_more_selected"];
    NSArray *titleArray = @[@"首页", @"监控", @"更多"];

    for (int i = 0; i < 3; i++) {
        UITabBarItem *barItem = _mainTabBarVC.tabBar.items[i];
        barItem.title = titleArray[i];
        barItem.image = [UIImage imageNamed:imageArray[i]];
        barItem.selectedImage = [UIImage imageNamed:selectedArray[i]];
    }
}

@end
