//
//  NSString+ZZExtends.h
//  HouseTransaction
//
//  Created by Jinsongzhuang on 4/1/15.
//  Copyright (c) 2015 chisalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZExtends)

// md5计算
+ (NSString *)md5String:(NSString *)source;

// app版本号
+ (NSString *)appVersionString;

// 获取时间戳
+ (NSString *)timeIntervalSince1970;

// 处理URL
+ (NSString *)redirectURL:(NSString *)sourceURL;

@end
