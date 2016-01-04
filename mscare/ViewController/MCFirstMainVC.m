//
//  MCFirstMainVC.m
//  mscare
//
//  Created by 朱正晶 on 15/8/31.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "MCFirstMainVC.h"
#import "HKSlideMenu3DController.h"
#import "SNAboutVC.h"
#import "AppDelegate.h"
#import "HBInsideVC.h"
#import "HBDeviceInfoCell.h"
#import "AppDelegate.h"
#import "KMNetAPI.h"

@interface MCFirstMainVC() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
/**
 *  室内数据模型
 */
@property (nonatomic, strong) HBSensorModel *insideModel;
/**
 *  室外数据模型
 */
@property (nonatomic, strong) HBSensorModel *outsideModel;

@end

@implementation MCFirstMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavBar];
    [self configView];
    
    // 获取数据
    [SVProgressHUD showWithStatus:@"正在获取数据"];
    [self requestInsideSensorData];
}

- (void)configNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_fenlei_topbar"]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(leftBarButtonDidClicked:)];
}

- (void)leftBarButtonDidClicked:(UIBarButtonItem *)sender
{
    [[AppDelegate mainDelegate].slideMenuVC toggleMenu];
}

- (void)configView
{
    [self setCustomTitle:@"设备列表"];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [UIView new];

    WS(ws);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws requestInsideSensorData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBDeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HBDeviceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    if (indexPath.row == 0) {
        cell.headImageView.image = [UIImage imageNamed:@"device_airpurifier_on_icon"];
        cell.topLable.text = @"室内";
        cell.bottomLable.text = @"温度 PM2.5 空气过滤器";
        cell.online = self.insideModel.online;
    } else if (indexPath.row == 1) {
        cell.headImageView.image = [UIImage imageNamed:@"personalprofile_icon_scene"];
        cell.topLable.text = @"室外";
        cell.bottomLable.text = @"温度 PM2.5";
        cell.online = self.outsideModel.online;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    HBInsideVC *vc = [[HBInsideVC alloc] init];
    switch (indexPath.row) {
        case 0:
            vc.sensorModel = self.insideModel;
            break;
        case 1:
            vc.sensorModel = self.outsideModel;
            break;
        default:
            break;
    }

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取网络数据
#pragma mark 室内
- (void)requestInsideSensorData
{
    WS(ws);

    [[KMNetAPI manager] getInsideDataFromServerWithBlock:^(int code, id resModel) {
        ws.insideModel = resModel;
        if (code == 0 && resModel) {
            // 继续获取
            [ws requestOutsideSensorData];
        } else {
            [ws.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:ws.insideModel.desc ? ws.insideModel.desc : @"获取室内传感器失败"];
        }
    }];
}

#pragma mark 室外
- (void)requestOutsideSensorData
{
    WS(ws);

    [[KMNetAPI manager] getOutSideDataFromServerWithBlock:^(int code, id resModel) {
        [SVProgressHUD dismiss];
        [ws.tableView.mj_header endRefreshing];
        ws.outsideModel = resModel;
        if (code == 0 && resModel) {
            // 刷新设备状态
            [ws.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:ws.insideModel.desc ? ws.outsideModel.desc : @"获取室外传感器失败"];
        }
    }];
}

@end
