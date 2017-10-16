//
//  OpenAwardDetailViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "OpenAwardDetailViewController.h"
#import "QGDetailModel.h"
#import "OpenAwardCell.h"
#import "INAwardViewController.h"
@interface OpenAwardDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableV;
    NSMutableArray *dataSource;
    NSInteger page;
    NSInteger totalPage;
}
@end

@implementation OpenAwardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-(kStatusBarHeight+kNavigationBarHeight+kHomeBarHeight))];
    tableV.tableFooterView = [UIView new];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreData];
    }];
    
    [self.view addSubview:tableV];
    [tableV.mj_header beginRefreshing];
}


- (void)refreshData {

    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@%@&page=%ld",self.url,self.lotteryNo,page] params:nil success:^(id responseObj) {
        [tableV.mj_header endRefreshing];
        if ([responseObj[@"code"] integerValue] == 3001) {
            
            dataSource = [QGDetailModel mj_objectArrayWithKeyValuesArray:responseObj[@"datas"]];
            [tableV reloadData];
            totalPage = [responseObj[@"pageNum"] integerValue];
        }
        
    } failure:^(NSError *error) {
        [tableV.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {

    if (totalPage == page) {
        
        [ZHProgressHUD showInfoWithText:@"没有更多数据了"];
        [tableV.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    page ++;
    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@%@&page=%ld",self.url,self.lotteryNo,page] params:nil success:^(id responseObj) {
        [tableV.mj_footer endRefreshing];
        if ([responseObj[@"code"] integerValue] == 3001) {
            
            if ([responseObj[@""] integerValue] == page) {
                [tableV.mj_footer endRefreshingWithNoMoreData];
            }
            
            [dataSource addObjectsFromArray:[QGDetailModel mj_objectArrayWithKeyValuesArray:responseObj[@"datas"]]];
            [tableV reloadData];
        }
        
    } failure:^(NSError *error) {
        [tableV.mj_footer endRefreshing];
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"HotCell";
    OpenAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OpenAwardCell" owner:self options:nil] lastObject];
    }
    QGDetailModel *model = dataSource[indexPath.row];
    cell.index = self.index;
    cell.qgDetailModel = model;
    if (self.segIndex == 2) {
        cell.arrow.hidden = YES;
    }else {
        cell.arrow.hidden = NO;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    INAwardViewController *awardInVC = [INAwardViewController new];
    QGDetailModel *model = dataSource[indexPath.row];
    awardInVC.lotid = model.lotId;
    awardInVC.title = self.title;
    
    if (self.segIndex == 0) {
        awardInVC.url = KOpenPrizeQGDetailIn;
    }else if (self.segIndex == 1) {

        awardInVC.url = KOpenPrizeDFDetailIN;
    }
    [self.navigationController pushViewController:awardInVC animated:YES];
}



@end
