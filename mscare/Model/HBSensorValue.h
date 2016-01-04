//
//  HBSensorValue.h
//  mscare
//
//  Created by 朱正晶 on 16/1/3.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBSensors.h"

@interface HBSensorValue : NSObject

/**
 *  节点名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  设备ID
 */
@property (nonatomic, copy) NSString *device_id;
/**
 *  传感器模型
 */
@property (nonatomic, strong) HBSensors *sensor;

@end
