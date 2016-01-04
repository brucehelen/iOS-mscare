//
//  KMNetAPI.h
//  InstantCare
//
//  Created by bruce-zhu on 15/12/4.
//  Copyright © 2015年 omg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBSensorModel.h"
#import "HBRelayModel.h"

/*
 * code: 请求是否成功，0成功，其他失败
 *  res: 从网络获取到的数据
 */
typedef void (^KMRequestResultBlock)(int code, id resModel);

@interface KMNetAPI : NSObject

+ (instancetype)manager;

/**
 *  获取室内传感器数据
 */
- (void)getInsideDataFromServerWithBlock:(KMRequestResultBlock)block;
/**
 *  获取室外传感器数据
 */
- (void)getOutSideDataFromServerWithBlock:(KMRequestResultBlock)block;
/**
 *  获取空气过滤器的状态
 *
 *  @param block 结果返回的block
 */
- (void)getRelayStatus:(KMRequestResultBlock)block;
/**
 *  更新空气过滤器状态
 *
 *  @param newStatus 是否打开
 *  @param block     结果返回block
 */
- (void)updateRelaysStatus:(BOOL)newStatus
                     block:(KMRequestResultBlock)block;

@end



