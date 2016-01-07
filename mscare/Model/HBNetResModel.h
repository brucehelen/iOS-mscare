//
//  HBNetResModel.h
//  mscare
//
//  Created by bruce-zhu on 16/1/6.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求通用API
 */
@interface HBNetResModel : NSObject
/**
 *  API请求结果
 *  0 -> 失败
 *  1 -> 成功
 */
@property (nonatomic, assign) NSInteger state;
/**
 *  请求结果描述
 */
@property (nonatomic, copy) NSString *desc;

@end
