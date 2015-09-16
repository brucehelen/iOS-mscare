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
#import "BZMapView.h"

#import "AppDelegate.h"

#import "BaseNavigationController.h"

#define kButtonLoginTag     1000
#define kButtonQRTag        1001
#define kButtonForgetTag    1002
#define kButtonApply        1003


@interface SNLoginVC ()

@property (nonatomic, strong) BZIconTextFieldView *userName;
@property (nonatomic, strong) BZIconTextFieldView *password;

@property (nonatomic, strong) M13Checkbox *autoLogin;
@property (nonatomic, strong) M13Checkbox *remenberMe;

@property (nonatomic, strong) UITabBarController *mainTabBarVC;

@end

@implementation SNLoginVC

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    [self configView];
}

- (void)configView
{
    // 背景
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"nttBg7"];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // 大图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"mhlogo"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).with.offset(-30);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.equalTo(self.view).multipliedBy(0.3);
    }];

    // 用户名
    _userName = [[BZIconTextFieldView alloc] init];
    _userName.iconView.image = [UIImage imageNamed:@"icon_member2"];
    _userName.textField.placeholder = NSLocalizedString(@"Username", @"LoginVC");
    [self.view addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view.mas_centerY);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.equalTo(@35);
    }];

    // 密码
    _password = [[BZIconTextFieldView alloc] init];
    _password.iconView.image = [UIImage imageNamed:@"icon_key2"];
    _password.textField.placeholder = NSLocalizedString(@"PassWord", @"LoginVC");
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(_userName.mas_bottom).with.offset(5);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.equalTo(@35);
    }];

    // 自动登录
    _autoLogin = [[M13Checkbox alloc] initWithFrame:CGRectZero
                                              title:NSLocalizedString(@"Auto Login", @"LoginVC")
                                        checkHeight:20];
    _autoLogin.strokeColor = [UIColor brownColor];
    _autoLogin.strokeWidth = 1;
    _autoLogin.titleLabel.font = [UIFont systemFontOfSize:15];
    [_autoLogin addTarget:self
                   action:@selector(checkChangedValue:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_autoLogin];
    [_autoLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).with.offset(-20);
        make.width.equalTo(@110);
        make.height.equalTo(@25);
        make.top.equalTo(_password.mas_bottom).with.offset(10);
    }];

    // 记住账号
    _remenberMe = [[M13Checkbox alloc] initWithFrame:CGRectZero
                                               title:NSLocalizedString(@"Remenber Me", @"LoginVC")
                                         checkHeight:20];
    _remenberMe.strokeColor = [UIColor brownColor];
    _remenberMe.strokeWidth = 1;
    _remenberMe.titleLabel.font = [UIFont systemFontOfSize:15];
    [_remenberMe addTarget:self
                   action:@selector(checkChangedValue:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_remenberMe];
    [_remenberMe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).with.offset(10);
        make.width.equalTo(@130);
        make.height.equalTo(@25);
        make.top.equalTo(_password.mas_bottom).with.offset(10);
    }];

    // 登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.tag = kButtonLoginTag;
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton setBackgroundImage:[UIImage imageNamed:@"icon_header_bar"]
                           forState:UIControlStateNormal];
    [loginButton setTitle:NSLocalizedString(@"Login", @"LoginVC")
                 forState:UIControlStateNormal];
    [loginButton addTarget:self
                    action:@selector(buttonDidClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_remenberMe.mas_bottom).with.offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@35);
    }];

    // 二维码登录
    UIButton *QRLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QRLoginButton.tag = kButtonQRTag;
    QRLoginButton.layer.cornerRadius = 5;
    QRLoginButton.clipsToBounds = YES;
    [QRLoginButton setBackgroundImage:[UIImage imageNamed:@"icon_header_bar"]
                           forState:UIControlStateNormal];
    [QRLoginButton setTitle:NSLocalizedString(@"QRCode Login", @"LoginVC")
                 forState:UIControlStateNormal];
    [QRLoginButton addTarget:self
                      action:@selector(buttonDidClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QRLoginButton];
    [QRLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(loginButton.mas_bottom).with.offset(5);
        make.width.equalTo(@200);
        make.height.equalTo(@35);
    }];

    // 忘记密码按钮
    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetPasswordButton.tag = kButtonForgetTag;
    [forgetPasswordButton setTitle:NSLocalizedString(@"Forget password", @"LoginVC")
                          forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self
                             action:@selector(buttonDidClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
    forgetPasswordButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:forgetPasswordButton];
    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).with.offset(-5);
        make.width.equalTo(@150);
        make.height.height.equalTo(@40);
        make.bottom.equalTo(self.view).with.offset(-5);
    }];

    // 注册账号
    UIButton *applyAccountButton = [UIButton buttonWithType:UIButtonTypeSystem];
    applyAccountButton.tag = kButtonApply;
    [applyAccountButton setTitle:NSLocalizedString(@"Apply account", @"LoginVC")
                        forState:UIControlStateNormal];
    [applyAccountButton setTitleColor:[UIColor blackColor]
                             forState:UIControlStateNormal];
    [applyAccountButton addTarget:self
                           action:@selector(buttonDidClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    applyAccountButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:applyAccountButton];
    [applyAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).with.offset(5);
        make.width.equalTo(@150);
        make.height.height.equalTo(@40);
        make.bottom.equalTo(self.view).with.offset(-5);
    }];
}

#pragma mark 单选框值改变事件
- (void)checkChangedValue:(M13Checkbox *)sender
{
    
}

- (void)buttonDidClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case kButtonLoginTag:       // 登录按钮
        {
            // do login...
            [AppDelegate mainDelegate].slideMenuVC.mainViewController = self.mainTabBarVC;
        } break;
        case kButtonQRTag:          // QRCode登录
            break;
        case kButtonForgetTag:      // 忘记密码
            break;
        case kButtonApply:          // 注册账号
            break;
        default:
            NSLog(@"Button tag unknown: %d", (int)sender.tag);
            break;
    }
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
    BZMapView *mapView = [[BZMapView alloc] initWithNibName:@"BZMapView" bundle:nil];
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:mapView];

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
    NSArray *titleArray = @[@"首页", @"我的", @"更多"];

    for (int i = 0; i < 3; i++) {
        UITabBarItem *barItem = _mainTabBarVC.tabBar.items[i];
        barItem.title = titleArray[i];
        barItem.image = [UIImage imageNamed:imageArray[i]];
        barItem.selectedImage = [UIImage imageNamed:selectedArray[i]];
    }
}

@end
