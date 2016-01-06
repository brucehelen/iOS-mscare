//
//  HBInsideVC.m
//  mscare
//
//  Created by 朱正晶 on 15/12/27.
//  Copyright © 2015年 kangmei. All rights reserved.
//

#import "HBInsideVC.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "HBSensorModel.h"
#import "KMNetAPI.h"
#import "UIView+i7Rotate360.h"

@interface HBInsideVC()

@property (nonatomic, strong) UILabel *requestLabel;
@property (nonatomic, strong) UILabel *requestLabel1;
/**
 *  PM2.5
 */
@property (nonatomic, strong) UILabel *pm2_5Label;
/**
 *  温度
 */
@property (nonatomic, strong) UILabel *tempLabel;
/**
 *  空气过滤器开关
 */
@property (nonatomic, strong) UIButton *airButton;
/**
 *  pm1.0
 */
@property (nonatomic, strong) UILabel *pm1_0Label;
/**
 *  pm10
 */
@property (nonatomic, strong) UILabel *pm10Label;
/**
 *  空气过滤器状态
 */
@property (nonatomic, strong) HBRelayModel *relayModel;

@end

@implementation HBInsideVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configNavBar];
    [self configView];
    [self reloadData];
    [self getAirStatus];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // 设置导航栏为透明色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 还原导航栏为原来的颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pic_top+titlebar_1334"]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)configView
{
    WS(ws);

    // 背景
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_backgroud_cesu_1136"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    // PM2.5的框
    UIImageView *pm2_5ImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_myluyoubao_home@3x"]];
    pm2_5ImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:pm2_5ImageView];
    [pm2_5ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view).offset(-150);
        make.width.height.equalTo(@180);
    }];

    UILabel *pm2_5TextLable = [[UILabel alloc] init];
    pm2_5TextLable.text = @"PM2.5";
    pm2_5TextLable.textColor = [UIColor whiteColor];
    pm2_5TextLable.font = [UIFont fontWithName:@"DINCond-Regular" size:25];
    [pm2_5ImageView addSubview:pm2_5TextLable];
    [pm2_5TextLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pm2_5ImageView);
    }];

    self.pm2_5Label = [[UILabel alloc] init];
    self.pm2_5Label.textColor = [UIColor whiteColor];
    self.pm2_5Label.font = [UIFont fontWithName:@"DINCond-Regular" size:38];
    [pm2_5ImageView addSubview:self.pm2_5Label];
    [self.pm2_5Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pm2_5ImageView);
        make.centerY.equalTo(pm2_5ImageView).offset(10);
    }];

    [pm2_5TextLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.pm2_5Label.mas_top).offset(-5);
    }];

    // pm1.0
    self.pm1_0Label = [[UILabel alloc] init];
    self.pm1_0Label.numberOfLines = 0;
    self.pm1_0Label.textColor = [UIColor whiteColor];
    self.pm1_0Label.font = [UIFont fontWithName:@"DINCond-Regular" size:20];
    self.pm1_0Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.pm1_0Label];
    [self.pm1_0Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view);
        make.right.equalTo(pm2_5ImageView.mas_left);
        make.centerY.equalTo(pm2_5ImageView);
    }];

    // pm10
    self.pm10Label = [[UILabel alloc] init];
    self.pm10Label.numberOfLines = 0;
    self.pm10Label.textColor = [UIColor whiteColor];
    self.pm10Label.font = [UIFont fontWithName:@"DINCond-Regular" size:20];
    self.pm10Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.pm10Label];
    [self.pm10Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pm2_5ImageView.mas_right);
        make.right.equalTo(ws.view);
        make.centerY.equalTo(pm2_5ImageView);
    }];

    // 温度
    self.tempLabel = [UILabel new];
    self.tempLabel.textColor = [UIColor whiteColor];
    self.tempLabel.font = [UIFont fontWithName:@"DINCond-Regular" size:30];
    [self.view addSubview:self.tempLabel];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.view.mas_centerY);
    }];
    
    // 空气过滤器开关
    self.airButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.airButton setImage:[UIImage imageNamed:@"device_airpurifier_off_icon"]
                    forState:UIControlStateNormal];
    [self.airButton setImage:[UIImage imageNamed:@"device_airpurifier_on_icon"]
                    forState:UIControlStateSelected];
    self.airButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.airButton addTarget:self action:@selector(airFanBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.airButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.airButton];
    [self.airButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.tempLabel.mas_bottom).offset(100);
        make.width.height.equalTo(@70);
    }];

    self.airButton.hidden = YES;
}

- (void)configNavBar
{
    if ([self.sensorModel.value.device_id isEqualToString:@"G3-001"]) {         // 室内
        self.navigationItem.title = @"室内";
    } else if ([self.sensorModel.value.device_id isEqualToString:@"G3-002"]) {  // 室外
        self.navigationItem.title = @"室外";
    }

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back_topbar"]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(leftBarButtonDidClicked:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_icon_update"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(rightBarButtonDidClicked:)];
}

#pragma mark - 返回
- (void)leftBarButtonDidClicked:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 刷新数据
- (void)rightBarButtonDidClicked:(UIBarButtonItem *)sender
{
    [self.airButton stop];

    WS(ws);
    [SVProgressHUD showWithStatus:@"正在获取数据"];
    NSLog(@"deviceID: %@", self.sensorModel.value.device_id);
    if ([self.sensorModel.value.device_id isEqualToString:@"G3-001"]) {     // 室内
        [[KMNetAPI manager] getInsideDataFromServerWithBlock:^(int code, id resModel) {
            [SVProgressHUD dismiss];
            if (code == 0 && resModel) {
                ws.sensorModel = resModel;
                [ws getAirStatus];
            } else {
                [SVProgressHUD showErrorWithStatus:ws.sensorModel.desc ? ws.sensorModel.desc : @"获取室内传感器失败"];
            }
        }];
    } else if ([self.sensorModel.value.device_id isEqualToString:@"G3-002"]) {
        [[KMNetAPI manager] getOutSideDataFromServerWithBlock:^(int code, id resModel) {
            [SVProgressHUD dismiss];
            if (code == 0 && resModel) {
                ws.sensorModel = resModel;
                [ws reloadData];
            } else {
                [SVProgressHUD showErrorWithStatus:ws.sensorModel.desc ? ws.sensorModel.desc : @"获取室外传感器失败"];
            }
        }];
    }
}

#pragma mark - 空气过滤器开关点击
- (void)airFanBtnDidClicked:(UIButton *)sender
{
    WS(ws);

    BOOL oldStatus = self.relayModel.value;

    [[KMNetAPI manager] updateRelaysStatus:!self.relayModel.value
                                     block:^(int code, id resModel) {
                                         if (code == 0 && resModel) {
                                             ws.relayModel = resModel;
                                             if (ws.relayModel.value == oldStatus) {
                                                 [SVProgressHUD showErrorWithStatus:@"操作失败"];
                                             }
                                             [ws reloadData];
                                         }
                                     }];
}

/**
 *  获取空气过滤器状态
 */
- (void)getAirStatus
{
    WS(ws);

    [[KMNetAPI manager] getRelayStatus:^(int code, id resModel) {
        [SVProgressHUD dismiss];
        if (code == 0 && resModel) {
            ws.relayModel = resModel;
        } else {
            [SVProgressHUD showErrorWithStatus:@"空气过滤器状态获取失败"];
        }

        [ws reloadData];
    }];
}

/**
 *  重新刷新界面
 */
- (void)reloadData
{
    NSLog(@"reloadData: %@", self.sensorModel.value.device_id);
    if (self.sensorModel) {
        self.pm2_5Label.text = [NSString stringWithFormat:@"%.1fug/m³", self.sensorModel.value.sensor.pm2_5];
        self.pm1_0Label.text = [NSString stringWithFormat:@"PM1.0\n%.1fug/m³", self.sensorModel.value.sensor.pm1_0];
        self.pm10Label.text = [NSString stringWithFormat:@"PM10\n%.1fug/m³", self.sensorModel.value.sensor.pm10];
        self.tempLabel.text = [NSString stringWithFormat:@"%.3f°", self.sensorModel.value.sensor.temp];

        if ([self.sensorModel.value.device_id isEqualToString:@"G3-001"]) {
            self.airButton.hidden = NO;
            if (self.relayModel.value == 1) {
                [self.airButton rotate360WithDuration:0.6 repeatCount:LONG_MAX timingMode:i7Rotate360TimingModeLinear];
            } else {
                [self.airButton stop];
            }
        } else {
            self.airButton.hidden = YES;
        }
    }
}

@end
