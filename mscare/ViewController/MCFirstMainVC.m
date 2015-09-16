//
//  MCFirstMainVC.m
//  mscare
//
//  Created by 朱正晶 on 15/8/31.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "MCFirstMainVC.h"
#import "HKSlideMenu3DController.h"
#import "SNAboutVC.h"
#import "AppDelegate.h"

@interface MCFirstMainVC()

@end

@implementation MCFirstMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configView];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)configView
{
    [self setCustomTitle:@"健康云手表"];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 200, 150, 50);
    button.backgroundColor = [UIColor greenColor];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_header_bar"]
                      forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonDidClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonDidClicked:(UIButton *)sender
{
    [[AppDelegate mainDelegate].slideMenuVC toggleMenu];
}

@end
