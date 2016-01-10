//
//  HBCameraVC.m
//  mscare
//
//  Created by 朱正晶 on 16/1/9.
//  Copyright © 2016年 kangmei. All rights reserved.
//

#import "HBCameraVC.h"
#import "KMNetAPI.h"
#import "UIImageView+WebCache.h"

@interface HBCameraVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HBCameraVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavBar];
    [self configView];
    [self rightBarButtonDidClicked:nil];
}

- (void)configNavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"about_icon_update"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(rightBarButtonDidClicked:)];
}

- (void)configView
{
    WS(ws);

    [self setCustomTitle:@"实时拍照"];

    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view).offset(80);
        make.height.equalTo(@(SCREENHEIGHT*0.5));
    }];
}

- (void)rightBarButtonDidClicked:(UIBarButtonItem *)sender
{
    WS(ws);

    [SVProgressHUD showWithStatus:@"正在拍照"];
    [[KMNetAPI manager] sendCameraCMDWithBlock:^(int code, id resModel) {
        [SVProgressHUD dismiss];
        HBCameraModel *model = resModel;
        if (code == 0 && model) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api/file/%@", kHostAddress, model.image]];
            [ws.imageView sd_setImageWithURL:url placeholderImage:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:model.desc ? model.desc : @"拍照失败"];
        }
    }];
}

@end
