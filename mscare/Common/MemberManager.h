//
//  MemberManager.h
//  MactuniAirCondition
//
//  Created by 朱正晶 on 15/7/21.
//  Copyright (c) 2015年 scinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define memberShare     [MemberManager shareInstance]

/**
 *  存储公共信息
 */
@interface MemberManager : NSObject

+ (MemberManager *)shareInstance;

/**
 *  用户名
 */
@property (atomic, copy) NSString *userName;
/**
 *  密码
 */
@property (atomic, copy) NSString *password;
/**
 *  访问API资源的凭证
 */
@property (atomic, copy) NSString *access_token;
/**
 *  Access_token过期时间
 */
@property (atomic, copy) NSString *expires_in;
/**
 *  上次成功登陆的时间
 */
@property (atomic, strong) NSDate *lastLoginDate;
/**
 *  当前网络连接
 */
@property (atomic, assign) NetworkStatus currentNetworkStatus;


@end
