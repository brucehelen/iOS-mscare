//
//  HBRelayModel.h
//  mscare
//
//  Created by 朱正晶 on 16/1/4.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  继电器数据模型
 */
@interface HBRelayModel : NSObject
/**
 *  API状态
 */
@property (nonatomic, assign) NSInteger state;
/**
 *  状态
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  风扇状态
 *  0 -> 关闭
 *  1 -> 打开
 */
@property (nonatomic, assign) NSInteger value;

@end
