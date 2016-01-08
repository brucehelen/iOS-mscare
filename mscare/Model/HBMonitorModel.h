//
//  HBMonitorModel.h
//  mscare
//
//  Created by bruce-zhu on 16/1/8.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  PIR和GAS状态模型
 */
@interface HBMonitorModel : NSObject
/**
 *  API请求结果是否OK
 */
@property (nonatomic, assign) NSInteger state;
/**
 *  API请求结果描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  防盗警报是否打开
 */
@property (nonatomic, assign) NSInteger pirEnable;
/**
 *  煤气报警是否打开
 */
@property (nonatomic, assign) NSInteger gasEnable;
/**
 *  PIR传感器当前状态
 *  0 -> 正常
 *  1 -> 异常
 */
@property (nonatomic, assign) NSInteger pir;
/**
 *  GAS传感器当前状态
 *  0 -> 正常
 *  1 -> 异常
 */
@property (nonatomic, assign) NSInteger gas;

@end
