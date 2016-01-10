//
//  HBCameraModel.h
//  mscare
//
//  Created by 朱正晶 on 16/1/10.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  拍照模型
 */
@interface HBCameraModel : NSObject

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *desc;
/**
 *  照片路径
 */
@property (nonatomic, copy) NSString *image;

@end
