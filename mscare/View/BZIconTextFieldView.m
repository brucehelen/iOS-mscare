//
//  BZIconTextFieldView.m
//  mscare
//
//  Created by MissionHealth on 15/8/25.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "BZIconTextFieldView.h"

#define kImageWidth         30
#define kTextFieldHeight    30
#define kEdgeOffset         10

@interface BZIconTextFieldView()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation BZIconTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }

    return self;
}

- (void)configView
{
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@kImageWidth);
    }];
    
    _textField = [[UITextField alloc] init];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).with.offset(kEdgeOffset);
        make.centerY.equalTo(self);
        make.height.equalTo(@kTextFieldHeight);
        make.right.equalTo(self);
    }];
}

@end
