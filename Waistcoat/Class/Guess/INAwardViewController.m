//
//  INAwardViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "INAwardViewController.h"
#import "AwardInHead.h"
#import "AwardInCell.h"
@interface INAwardViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *tableV;
    AwardInHead *headView;
    NSDictionary *datas;
}
@end

@implementation INAwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    headView = [[[NSBundle mainBundle] loadNibNamed:@"AwardInHead" owner:self options:nil] lastObject];
    headView.frame = CGRectMake(0, 0, kDeviceWidth, 140);
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-(kStatusBarHeight+kNavigationBarHeight+kHomeBarHeight))];
    tableV.tableFooterView = [UIView new];
    tableV.tableHeaderView = headView;
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    
    [self.view addSubview:tableV];
    [tableV.mj_header beginRefreshing];
    
}

- (void)refreshData {

    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&lotid=%@",self.url,self.lotid] params:nil success:^(id responseObj) {
        
        [tableV.mj_header endRefreshing];
        NSLog(@"responseObj = %@",responseObj);
        if ([responseObj[@"code"] integerValue] == 3001) {
            
            datas = responseObj[@"datas"];
            headView.typeNAme.text = self.title;
            headView.dateLab.text = ![datas[@"issue"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@期",datas[@"issue"]] : @"";
            headView.timeLab.text = ![datas[@"prizeDate"] isKindOfClass:[NSNull class]] ? datas[@"prizeDate"] : responseObj[@"systime"];
            headView.bqxsLab.text = ![datas[@"sale"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@",datas[@"sale"]] : @"";
            headView.jcgcLab.text = ![datas[@"pool"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@",datas[@"pool"]] : @"";
            tableV.delegate = self;
            tableV.dataSource = self;
            [tableV reloadData];
        }
        
    } failure:^(NSError *error) {
        
        [tableV.mj_header endRefreshing];
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *reList = datas[@"reList"];
    if ([datas[@"reList"] isKindOfClass:[NSNull class]]) {
        
        return 0;
    }
    
    return reList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"HotCell";
    AwardInCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AwardInCell" owner:self options:nil] lastObject];
    }

    NSArray *reList = datas[@"reList"];
    NSDictionary *dic = reList[indexPath.row];
    
    cell.Lab1.text = ![datas[@"awards"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@",dic[@"awards"]] : @"";
    cell.Lab2.text = ![datas[@"single_Note_Bonus"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@",dic[@"single_Note_Bonus"]] : @"";
    cell.Lab3.text = ![datas[@"winningNote"] isKindOfClass:[NSNull class]] ? [NSString stringWithFormat:@"%@",dic[@"winningNote"]] : @"";
    
    return cell;
}



@end
