//
//  SNUtility.m
//  SHome-I
//
//  Created by KevinWen on 10/28/13.
//  Copyright (c) 2013 SCINANIOT. All rights reserved.
//

#import "SNUtility.h"
#import "Reachability.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#import "MJExtension.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation SNUtility

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";

    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    if (([regextestmobile evaluateWithObject:mobileNum] == YES) ||
        ([regextestcm evaluateWithObject:mobileNum] == YES) ||
        ([regextestct evaluateWithObject:mobileNum] == YES) ||
        ([regextestcu evaluateWithObject:mobileNum] == YES)) {

        return YES;
    }

    return NO;
}

+ (NSString*)currentLanguage
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    NSString* currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

/**
 *  设备屏幕实际分辨率
 *
 *  @return 屏幕物理分辨率
 */
+ (CGSize)getScreenSize
{
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    size_screen.height=size_screen.height*scale_screen;
    size_screen.width=size_screen.width*scale_screen;
    
    return size_screen;
}

+ (BOOL)isLettersAndNumbers:(NSString *)string
{
    int len= (int)(string.length);

    for (int i = 0; i < len; i++) {
        unichar a = [string characterAtIndex:i];
        if( (isalpha(a) || isalnum(a)) == NO)
            return NO;
    }

    return YES;
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];

    return [emailTest evaluateWithObject:email];
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+(NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (id)fetchSSIDInfo
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }

    return info;
}

+ (void)recordUsableWifi
{
    NSDictionary *ifs =[SNUtility fetchSSIDInfo];

    NSLog(@"current using ssid=%@",[ifs valueForKey:@"SSID"]);
    if (ifs)
    {
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ssidDict=[accountDefaults objectForKey:@"SSID"];
        if (!ssidDict)
        {
            ssidDict =[[NSMutableArray alloc] init];
        }
        
        if(![ssidDict containsObject:[ifs valueForKey:@"SSID"]])
        {
            if((![[ifs valueForKey:@"SSID"] hasPrefix:@"SN_"]) && ([[ifs valueForKey:@"SSID"] length]!=22)){
                
                [ssidDict addObject:[ifs valueForKey:@"SSID"]];
                [accountDefaults setObject:ssidDict forKey:@"SSID"];
            }
        }
        NSLog(@"current all ssids:%@",[accountDefaults objectForKey:@"SSID"]);
    }
}

+ (NSString *)stringFromHexString2:(NSString *)hexString
{
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }

    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

+ (NSString *)stringFromBytes:(Byte *) byte bytesLen:(int)len
{
    NSData * data = [[NSData alloc] initWithBytes:byte length:len];
    NSString * s = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding];
    return s ;
    
}

+ (Byte)numFromChar:(char)c
{
    if ( c >='0' && c <= '9')
    {
        return c - '0';
    }else if (c >='A' && c <='Z') {
        return c - 'A' + 10;
    }else if (c >='a' && c <= 'z') {
        return c - 'a' + 10;
    }
    return -1;
}


+ (NSData *)dataFromHexString:(NSString *) s_t
{
    // 4F60 597D
    //0100 1111

    s_t = [s_t stringByReplacingOccurrencesOfString:@" "  withString: @""];
    
    if ([s_t length]%2 !=0)
    {
        return nil;
    }
    
    Byte * retBytes = malloc(sizeof(char) * [s_t length]);
    
    Byte * ori = retBytes;
    
    for ( int i = 0 ; i < [s_t length]; )
    {
        char highBit = [s_t characterAtIndex:i ++];
        
        char lowBit = [s_t characterAtIndex:i ++];
        
        //to byte
        Byte a = [self numFromChar:highBit];
        Byte b = [self numFromChar:lowBit];
        
        *(retBytes ++)= (a<<4) | b;
    }
    
    NSData * data = [NSData dataWithBytes:ori length:[s_t length]/2];
    
    return data;
}


+ (NSString * )stringFromByte:(Byte ) byteVal;
{
    NSMutableString *str = [NSMutableString string];
    Byte byte1 = byteVal >> 4;
    Byte byte2 = byteVal & 0xf;
    [str appendFormat:@"%x" , byte1];
    [str appendFormat:@"%x" , byte2];
    return str;
}

//0000 0000 0000 0000

+ (NSString *) stringFromShort :(short) shortVal
{
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%x" , shortVal >> 12];
    [str appendFormat:@"%x" , (shortVal >> 8 ) & 0xf ];
    [str appendFormat:@"%x" , (shortVal >> 4 ) & 0xf];
    [str appendFormat:@"%x" , shortVal &0xf];
    return str;
}


+ (NSString * ) hexStringfromData:(NSData * )data
{
    NSMutableString * str = [NSMutableString string];
    
    Byte * byte = (Byte *)[data bytes];
    for ( int i = 0 ;i < [data length] ;i ++)
    {
        [str appendString:[self stringFromByte: *(byte + i)] ];
    }
    
    return str;
}

+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (unsigned int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }

    NSLog(@"Encryption Result = %@",hash);
    return hash;
}

/**
 *  弹出提示信息
 *
 *  @param message 提示消息
 */
+ (void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Prompt", nil)
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

/**
 *  效果和Andriod的toast一样
 *
 *  @param msg  提示信息
 *  @param view 在哪个view上面显示toast
 */
+ (void)toast:(NSString *)msg view:(UIView *)view
{
    [view makeToast:msg duration:1.0 position:CSToastPositionBottom];
}

/**
 *  缩小图片
 *
 *  @param image     原始图片
 *  @param scaleSize 缩小比例
 *
 *  @return 新图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize,
                                           image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0,
                                 0,
                                 image.size.width * scaleSize,
                                 image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return scaledImage;
}

// 0,3,001=,0049,001<,0000,0014,0000,0049,0049,0049,0049,0049,0049,0049,0049,0049,0049,1,1,085>,
/**
 *  苏州盟通利专用API
 *
 *  @param originString 原始字符串
 *
 *  @return 处理完成的字符数组
 */
+ (NSArray *)hexStringConversation:(NSString *)originString
{
    NSMutableArray *resultArray = [NSMutableArray array];

    NSArray *arrayString = [originString componentsSeparatedByString:@","];
    for (NSString *str in arrayString) {
        [resultArray addObject:[self replaceWithString:str]];
    }

    return resultArray;
}

/**
 *  替换字符串中的:;<=>?  --->  ABCDEF
 *
 *  @param string 原始字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString *)replaceWithString:(NSString *)string
{
    return [SNUtility replaceWithString:string direction:YES];
}

/**
 *  字符串中的:;<=>?  --->  ABCDEF 相互替换
 *
 *  @param string 原始字符串
 *  @param dir    方向，YES(:;<=>?  --->  ABCDEF), NO(ABCDEF  --->  :;<=>?)
 *
 *  @return 替换好的字符串
 */
+ (NSString *)replaceWithString:(NSString *)string direction:(BOOL)dir
{
    NSArray *replaceString = @[@":", @";", @"<", @"=", @">", @"?"];
    NSArray *theNewString = @[@"A", @"B", @"C", @"D", @"E", @"F"];

    NSMutableString *originStr = [NSMutableString stringWithString:string];

    if (dir == YES) {
        for (int i = 0; i < replaceString.count; i++) {
            [originStr replaceOccurrencesOfString:replaceString[i]
                                       withString:theNewString[i]
                                          options:NSCaseInsensitiveSearch
                                            range:NSMakeRange(0, string.length)];
        }
    } else {
        for (int i = 0; i < replaceString.count; i++) {
            [originStr replaceOccurrencesOfString:theNewString[i]
                                       withString:replaceString[i]
                                          options:NSCaseInsensitiveSearch
                                            range:NSMakeRange(0, string.length)];
        }
    }

    return originStr;
}

+ (unsigned)hexStringToLong:(NSString *)hexString
{
    NSScanner* scanner = [NSScanner scannerWithString:hexString];

    unsigned int longValue;
    [scanner scanHexInt:&longValue];
    return longValue;
}


@end


