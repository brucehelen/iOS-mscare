//
//  HBSensorModel.h
//  mscare
//
//  Created by 朱正晶 on 15/12/28.
//  Copyright © 2015年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBSensorValue.h"

@interface HBSensorModel : NSObject
/**
 *  API请求结果
 *  0 -> 错误
 *  1 -> 成功
 */
@property (nonatomic, assign) NSInteger status;
/**
 *  API结果描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  设备是否在线
 *  0 -> 不在线
 *  1 -> 在线
 */
@property (nonatomic, assign) NSInteger online;
/**
 *  最后汇报时间
 */
@property (nonatomic, assign) double last_report;
/**
 *  设备连接服务器时间
 */
@property (nonatomic, assign) double connect_time;
/**
 *  传感器
 */
@property (nonatomic, strong) HBSensorValue *value;

@end
