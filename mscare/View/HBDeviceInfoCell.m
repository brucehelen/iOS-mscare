//
//  HBDeviceInfoCell.m
//  mscare
//
//  Created by 朱正晶 on 15/12/27.
//  Copyright © 2015年 kangmei. All rights reserved.
//

#import "HBDeviceInfoCell.h"

#define kHeadImageWidth     40
#define kTopLableW          150
#define kTopLableH          40

@interface HBDeviceInfoCell()

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *topLable;
@property (nonatomic, strong) UILabel *bottomLable;
/**
 *  在线状态
 */
@property (nonatomic, strong) UIButton *onlineBtn;

@end

@implementation HBDeviceInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
    }
    
    return self;
}

- (void)configView
{
    WS(ws);

    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(20);
        make.width.height.equalTo(@kHeadImageWidth);
        make.centerY.equalTo(ws.contentView);
    }];

    self.topLable = [[UILabel alloc] init];
    self.topLable.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.topLable];
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.headImageView.mas_right).offset(10);
        make.right.equalTo(ws.contentView);
        make.top.equalTo(ws.headImageView);
    }];

    self.bottomLable = [[UILabel alloc] init];
    self.bottomLable.font = [UIFont systemFontOfSize:14];
    self.bottomLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.bottomLable];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.headImageView.mas_right).offset(10);
        make.right.equalTo(ws.contentView);
        make.bottom.equalTo(ws.headImageView);
    }];

    self.onlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.onlineBtn setImage:[UIImage imageNamed:@"gateway_log_unsel"]
                    forState:UIControlStateNormal];
    [self.onlineBtn setImage:[UIImage imageNamed:@"gateway_log_sel"]
                    forState:UIControlStateSelected];
    [self.contentView addSubview:self.onlineBtn];
    [self.onlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.right.equalTo(ws.contentView).offset(-50);
    }];
}

- (void)setOnline:(BOOL)online
{
    _online = online;
    if (online) {
        self.onlineBtn.selected = YES;
    } else {
        self.onlineBtn.selected = NO;
    }
}

@end
