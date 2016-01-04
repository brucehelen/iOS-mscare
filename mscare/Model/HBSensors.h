//
//  HBSensors.h
//  mscare
//
//  Created by 朱正晶 on 16/1/3.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBSensors : NSObject
/**
 *  温度
 */
@property (nonatomic, assign) double temp;
/**
 *  pm1.0
 */
@property (nonatomic, assign) double pm1_0;
/**
 *  pm2.5
 */
@property (nonatomic, assign) double pm2_5;
/**
 *  pm10
 */
@property (nonatomic, assign) double pm10;

@end
