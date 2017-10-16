//
//  PostDetailViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "PostDetailViewController.h"
#import "PostDetailModel.h"
#import "PostDetailHead.h"
#import "PostDetailCell.h"
@interface PostDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    PostDetailModel *model;
    UITableView *tableV;
}
@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-(kStatusBarHeight+kNavigationBarHeight+kHomeBarHeight))];
    tableV.tableFooterView = [UIView new];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorColor = [UIColor clearColor];
    tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self ReloadData];
    }];
    [self.view addSubview:tableV];
    [tableV.mj_header beginRefreshing];
    
}

- (void)ReloadData {

    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&postId=%@",KPostDetail,self.postId] params:nil success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        
        [tableV.mj_header endRefreshing];
        
        if ([responseObj[@"result"] integerValue] == 100) {
            model = [PostDetailModel mj_objectWithKeyValues:responseObj[@"post"]];
            
            PostDetailHead *head = [[[NSBundle mainBundle] loadNibNamed:@"PostDetailHead" owner:self options:nil] lastObject];
            head.frame = CGRectMake(0, 0, kDeviceWidth, model.headHeight);
            head.postDetailModel = model;
            tableV.tableHeaderView = head;
            
            [tableV reloadData];
        }
    } failure:^(NSError *error) {
        [tableV.mj_header endRefreshing];
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return model.comments.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 85;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *reuser = @"HotCell";
        PostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PostDetailCell" owner:self options:nil] lastObject];
        }
        NSDictionary *commonDic =  model.comments[indexPath.row];
        cell.dic = commonDic;
    
        return cell;
}




@end
