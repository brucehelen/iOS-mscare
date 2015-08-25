//
//  UIImageView+Cache.h
//  HouseTransaction
//
//  Created by 朱正晶 on 15/4/24.
//  Copyright (c) 2015年 chisalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (Cache)

- (void)imageCache:(NSString *)url;

- (void)imageCache:(NSString *)url placeholderImage:(NSString *)placeholder;

@end
