//
//  SNAboutVC.m
//  SHHI
//
//  Created by 朱正晶 on 15/7/22.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import "SNAboutVC.h"

@interface SNAboutVC ()

@end

@implementation SNAboutVC

+ (SNAboutVC *)shareInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });

    return _sharedObject;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
}

@end
