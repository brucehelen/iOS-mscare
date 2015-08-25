//
//  NSString+ZZExtends.m
//  HouseTransaction
//
//  Created by Jinsongzhuang on 4/1/15.
//  Copyright (c) 2015 chisalsoft. All rights reserved.
//

#import "NSString+ZZExtends.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZZExtends)

+ (NSString *)md5String:(NSString *)string
{
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02X",outputBuffer[count]];
    }

    return outputString;
}

+ (NSString *)appVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)timeIntervalSince1970
{
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}

/**
 *  检查URL地址，加入host地址
 *
 *  @param sourceURL 源URL
 *
 *  @return 新URL地址
 */
+ (NSString *)redirectURL:(NSString *)sourceURL
{
    if (sourceURL) {

        NSString *url;

        if ([sourceURL rangeOfString:@"http"].length == 0) {
            url = [kHostAddress stringByAppendingString:sourceURL];
        } else {
            url = sourceURL;
        }

        return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    return nil;
}



@end
