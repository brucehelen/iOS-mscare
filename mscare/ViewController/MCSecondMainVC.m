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

@interface MCSecondMainVC() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MCSecondMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self configNavBar];
    [self configView];
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
    self.tableView.tableFooterView = [UIView new];

    WS(ws);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
}

/**
 *  获取监控信息：PIR和GAS状态
 */
- (void)requestMonitor
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }
    
    return cell;
}

@end
