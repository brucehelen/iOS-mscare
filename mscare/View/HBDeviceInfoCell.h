//
//  HBDeviceInfoCell.h
//  mscare
//
//  Created by 朱正晶 on 15/12/27.
//  Copyright © 2015年 kangmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBDeviceInfoCell : UITableViewCell

@property (nonatomic, readonly, strong) UIImageView *headImageView;
@property (nonatomic, readonly, strong) UILabel *topLable;
@property (nonatomic, readonly, strong) UILabel *bottomLable;
/**
 *  在线状态
 */
@property (nonatomic, assign) BOOL online;

@end
