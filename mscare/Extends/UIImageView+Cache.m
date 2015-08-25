//
//  UIImageView+Cache.m
//  HouseTransaction
//
//  Created by 朱正晶 on 15/4/24.
//  Copyright (c) 2015年 chisalsoft. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "NSString+ZZExtends.h"
#import "MemberManager.h"

@implementation UIImageView (Cache)

- (void)imageCache:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString redirectURL:url]]];
}

- (void)imageCache:(NSString *)url placeholderImage:(NSString *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString redirectURL:url]]
            placeholderImage:[UIImage imageNamed:placeholder]];
}

@end
