//
//  BZIconTextFieldView.h
//  mscare
//
//  Created by MissionHealth on 15/8/25.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import <UIKit/UIKit.h>

// Icon + TextField
@interface BZIconTextFieldView : UIView

// 前面的图标
@property (nonatomic, strong, readonly) UIImageView *iconView;
// 后面的文本输入框
@property (nonatomic, strong, readonly) UITextField *textField;

@end
