//
//  SNUtility.h
//  SHome-I
//
//  Created by KevinWen on 10/28/13.
//  Copyright (c) 2013 SCINANIOT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#define NETWORK_NONE    0
#define NETWORK_WIFI    2
#define NETWORK_3G      1

@interface SNUtility : NSObject

+ (id)fetchSSIDInfo;
+ (void)recordUsableWifi;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (NSString *)currentLanguage;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString *)stringFromBytes:(Byte *) byte bytesLen:(int)len;
+ (NSData *)dataFromHexString:(NSString *) s_t;

+ (NSString *)md5HexDigest:(NSString*)password;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (CGSize)getScreenSize;
+ (BOOL)isLettersAndNumbers:(NSString *)string;

/**
 *  弹出提示信息
 *
 *  @param message 提示消息
 */
+ (void)showAlertWithMessage:(NSString *)message;

/**
 *  效果和Andriod的toast一样
 *
 *  @param msg  提示信息
 *  @param view 在哪个view上面显示toast
 */
+ (void)toast:(NSString *)msg view:(UIView *)view;

/**
 *  缩小图片
 *
 *  @param image     原始图片
 *  @param scaleSize 缩小比例
 *
 *  @return 新图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  苏州盟通利专用API
 *
 *  @param originString 原始字符串
 *
 *  @return 处理完成的字符数组
 */
+ (NSArray *)hexStringConversation:(NSString *)originString;

/**
 *  字符串中的:;<=>?  --->  ABCDEF转换
 *
 *  @param string 带:;<=>?字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString *)replaceWithString:(NSString *)string;

/**
 *  字符串中的:;<=>?  --->  ABCDEF 相互替换
 *
 *  @param string 原始字符串
 *  @param dir    方向，YES(:;<=>?  --->  ABCDEF), NO(ABCDEF  --->  :;<=>?)
 *
 *  @return 替换好的字符串
 */
+ (NSString *)replaceWithString:(NSString *)string direction:(BOOL)dir;

/**
 *  将十六进制的字符串转成long
 *
 *  @param hexString 待转换的字符串
 *
 *  @return long
 */
+ (unsigned)hexStringToLong:(NSString *)hexString;


@end

