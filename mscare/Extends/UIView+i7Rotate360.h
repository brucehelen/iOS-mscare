//
//  UIView+i7Rotate360.h
//  mscare
//
//  Created by 朱正晶 on 16/1/4.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import <UIKit/UIKit.h>

enum i7Rotate360TimingMode
{
    i7Rotate360TimingModeEaseInEaseOut,
    i7Rotate360TimingModeLinear
};

@interface UIView (i7Rotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode;
- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode;
- (void)rotate360WithDuration:(CGFloat)aDuration;
- (void)stop;

@end