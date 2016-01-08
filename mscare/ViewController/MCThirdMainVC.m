//
//  MCThirdMainVC.m
//  mscare
//
//  Created by 朱正晶 on 15/8/31.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "MCThirdMainVC.h"

@implementation MCThirdMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configView];
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

    self.view.backgroundColor = RGBA(10, 10, 13, 1);
    
    // 开源大赛背景
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"ickey_start"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view).multipliedBy(0.5);
        make.width.equalTo(ws.view);
        make.height.equalTo(ws.view).multipliedBy(0.4);
    }];
    
    // 项目名称
    UILabel *projectLabel = [UILabel new];
    projectLabel.text = @"参赛作品";
    projectLabel.font = [UIFont boldSystemFontOfSize:22];
    projectLabel.textAlignment = NSTextAlignmentCenter;
    projectLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:projectLabel];
    [projectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.left.right.equalTo(ws.view);
        make.height.equalTo(@30);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = RGBA(79, 218, 85, 1);
    nameLabel.text = @"智慧家庭(SmartHome)";
    nameLabel.font = [UIFont boldSystemFontOfSize:27];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(projectLabel);
        make.top.equalTo(projectLabel.mas_bottom).offset(20);
        make.left.right.equalTo(ws.view);
        make.height.equalTo(@30);
    }];
    
    UILabel *authorLabel = [UILabel new];
    authorLabel.textColor = RGBA(11, 111, 225, 1);
    authorLabel.text = @"ID: 小麦克\nQQ: 378214384\n378214384@qq.com";
    authorLabel.numberOfLines = 0;
    authorLabel.font = [UIFont systemFontOfSize:18];
    authorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:authorLabel];
    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(projectLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.left.right.equalTo(ws.view);
        make.height.equalTo(@90);
    }];

}

@end
