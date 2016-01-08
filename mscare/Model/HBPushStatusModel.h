//
//  HBPushStatusModel.h
//  mscare
//
//  Created by bruce-zhu on 16/1/8.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBPushStatusModel : NSObject

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *desc;
/**
 *  PIR传感器推送状态
 *  "0" -> 关闭
 *  "1" -> 打开
 */
@property (nonatomic, copy) NSString *pir;
/**
 *  GAS传感器状态
 *  "0" -> 关闭
 *  "1" -> 打开
 */
@property (nonatomic, copy) NSString *gas;
/**
 *  当前存储的推送Token
 */
@property (nonatomic, copy) NSString *token;

@end
