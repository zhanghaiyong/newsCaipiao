//
//  CircelDetailViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CircelDetailViewController.h"
#import "HotPostCell.h"
#import "HotPostsModel.h"
#import "CircleHead.h"
#import "PostDetailViewController.h"
#import "CircelNoticeViewController.h"
@interface CircelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSArray     *hotDataSources;
    NSDictionary *headDic;
    UITableView *TableV;
}
@end

@implementation CircelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TableV = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-(kStatusBarHeight+kNavigationBarHeight+kHomeBarHeight))];
    TableV.tableFooterView = [UIView new];
    TableV.delegate = self;
    TableV.dataSource = self;
    TableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self hotRequestData];
    }];
    [self.view addSubview:TableV];
    [TableV.mj_header beginRefreshing];

}


- (void)hotRequestData {

    [KSMNetworkRequest postRequest:[NSString stringWithFormat:@"%@&boardId=%@",KCircleDetail,self.circleListModel.boardId] params:nil success:^(id responseObj) {
        [TableV.mj_header endRefreshing];
        
        if ([responseObj[@"result"] integerValue] == 100) {
            
            hotDataSources = [HotPostsModel mj_objectArrayWithKeyValuesArray:responseObj[@"posts"]];
            headDic = responseObj[@"board"];
            [TableV reloadData];
        }
        
        
    } failure:^(NSError *error) {
        
        [TableV.mj_header endRefreshing];
    }];
}


#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CircleHead *head = [[[NSBundle mainBundle] loadNibNamed:@"CircleHead" owner:self options:nil] lastObject];
    head.frame = CGRectMake(0, 0, kDeviceWidth, 50);
    
    [head.image sd_setImageWithURL:[NSURL URLWithString:headDic[@"boardIconUrl"]] placeholderImage:[UIImage imageNamed:@""]];
    head.naleLab.text = headDic[@"boardName"];
    head.lab1.text = [NSString stringWithFormat:@"圈内人数 %@",headDic[@"peopleNum"]];
    head.lab2.text = [NSString stringWithFormat:@"帖子 %@",headDic[@"postsNum"]];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return hotDataSources.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    HotPostsModel *model =  hotDataSources[indexPath.row];
    
    if ([model.showTag integerValue] == 1) {
        return 30;
    }
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotPostsModel *model =  hotDataSources[indexPath.row];
    
    if ([model.showTag integerValue] == 1) {
        
        static NSString *reuser = @"circelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuser];
        }
        
        cell.textLabel.text = @"公告";
        cell.detailTextLabel.text = model.text;
        cell.detailTextLabel.textColor = [UIColor fromHexValue:0x555555];
        
        return cell;
    }else {
        
        static NSString *reuser = @"HotCell";
        HotPostCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotPostCell" owner:self options:nil] lastObject];
        }
        HotPostsModel *model =  hotDataSources[indexPath.row];
        cell.hotPostsModel = model;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HotPostsModel *model = hotDataSources[indexPath.row];
    
    if ([model.showTag integerValue] == 1) {
        
        CircelNoticeViewController *CircelNoticeVC = [CircelNoticeViewController new];
        
        CircelNoticeVC.title = @"详情";
        CircelNoticeVC.model = model;
        CircelNoticeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:CircelNoticeVC animated:YES];
        
    }else{
    
        PostDetailViewController *PostDetailVC = [PostDetailViewController new];
        PostDetailVC.postId = model.postId;
        PostDetailVC.title = @"详情";
        PostDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:PostDetailVC animated:YES];
    }
    

}


@end
