//
//  MCSecondMainVC.m
//  mscare
//
//  Created by 朱正晶 on 15/8/31.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import "MCSecondMainVC.h"
#import "AppDelegate.h"
#import "KMNetAPI.h"
#import "HBDeviceInfoCell.h"

@interface MCSecondMainVC() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HBMonitorModel *monitorModel;

@property (nonatomic, strong) HBPushStatusModel *gasPushModel;

@end

@implementation MCSecondMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self configNavBar];
    [self configView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestMonitor];
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
    [self setCustomTitle:@"监控列表"];

    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.allowsSelection = NO;
    self.tableView.tableFooterView = [UIView new];

    WS(ws);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws requestMonitor];
    }];
}

/**
 *  获取监控信息：PIR和GAS状态
 */
- (void)requestMonitor
{
    WS(ws);

    [[KMNetAPI manager] getMonitorStatus:^(int code, id resModel) {
        [self.tableView.mj_header endRefreshing];
        if (code == 0 && [resModel isKindOfClass:[HBMonitorModel class]]) {
            ws.monitorModel = resModel;
            [ws.tableView reloadData];
        }
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
        cell = [[HBDeviceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"cell"];
        cell.switchOn.hidden = NO;
        
        [cell.switchOn addTarget:self
                          action:@selector(switchDidClick:)
                forControlEvents:UIControlEventValueChanged];
    }

    cell.switchOn.tag = indexPath.row;
    switch (indexPath.row) {
        case 0:
            cell.headImageView.image = [UIImage imageNamed:@"pir"];
            cell.topLable.text = @"HC-SR501红外传感器";
            cell.bottomLable.text = self.monitorModel.pir == 0 ? @"状态: 正常" : @"状态: 异常";
            cell.bottomLable.textColor = self.monitorModel.pir == 0 ? [UIColor grayColor] : [UIColor redColor];
            cell.switchOn.on = self.monitorModel.pirEnable;
            break;
        case 1:
            cell.headImageView.image = [UIImage imageNamed:@"gas"];
            cell.topLable.text = @"MQ-5气体传感器";
            cell.bottomLable.text = self.monitorModel.gas == 0 ? @"状态: 正常" : @"状态: 异常";
            cell.bottomLable.textColor = self.monitorModel.gas == 0 ? [UIColor grayColor] : [UIColor redColor];
            cell.switchOn.on = self.monitorModel.gasEnable;
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark - UISwitch-更新防盗设定
- (void)switchDidClick:(UISwitch *)mSwitch
{
    BOOL state = mSwitch.isOn;

    switch (mSwitch.tag) {
        case 0:         // PIR
        {
            [SVProgressHUD showWithStatus:@"正在获取数据"];
            [[KMNetAPI manager] updatePIRRemotePushWithUser:@"Bruce"
                                                  newStatus:state
                                                      block:^(int code, id resModel) {
                                                          [SVProgressHUD dismiss];
                                                          if (code == 0 && resModel) {
                                                              
                                                          } else {
                                                              [SVProgressHUD showErrorWithStatus:@"设置失败"];
                                                          }
                                                      }];
        } break;
        case 1:         // GAS
        {
            [SVProgressHUD showWithStatus:@"正在获取数据"];
            [[KMNetAPI manager] updateGASRemotePushWithUser:@"Bruce"
                                                  newStatus:state
                                                      block:^(int code, id resModel) {
                                                          [SVProgressHUD dismiss];
                                                          if (code == 0 && resModel) {
                                                              
                                                          } else {
                                                              [SVProgressHUD showErrorWithStatus:@"设置失败"];
                                                          }
                                                      }];
        } break;
        default:
            break;
    }
}

@end
