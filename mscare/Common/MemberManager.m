//
//  MemberManager.m
//  MactuniAirCondition
//
//  Created by 朱正晶 on 15/7/21.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import "MemberManager.h"

@implementation MemberManager

+ (MemberManager *)shareInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;

    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });

    return _sharedObject;
}

#pragma mark - userName
- (void)setUserName:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}

- (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

#pragma mark - password
- (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}

- (NSString *)password
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

#pragma mark - expires_in
- (void)setExpires_in:(NSString *)expires_in
{
    [[NSUserDefaults standardUserDefaults] setObject:expires_in forKey:@"expires_in"];
}

- (NSString *)expires_in
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"];
}

#pragma mark - lastLoginDate
- (void)setLastLoginDate:(NSDate *)lastLoginDate
{
    [[NSUserDefaults standardUserDefaults] setObject:lastLoginDate forKey:@"lastLoginDate"];
}

- (NSDate *)lastLoginDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastLoginDate"];
}

#pragma mark - deviceToken
- (void)setDeviceToken:(NSString *)deviceToken
{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
}
- (NSString *)deviceToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
}

@end
