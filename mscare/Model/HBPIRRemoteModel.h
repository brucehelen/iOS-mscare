//
//  HBPIRRemoteModel.h
//  mscare
//
//  Created by bruce-zhu on 16/1/7.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  PIR结果模型
 */
@interface HBPIRRemoteModel : NSObject
/**
 *  API请求结果错误码
 *  0 -> API请求失败
 *  1 -> API请求成功
 */
@property (nonatomic, assign) NSInteger state;
/**
 *  API请求结果描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  是否打开推送功能
 *  "0" -> 推送已经关闭
 *  "1" -> 推送已经打开
 */
@property (nonatomic, copy) NSString *iOSEnablePIRPush;

@end
