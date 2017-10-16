//
//  CircelsViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CircelsViewController.h"
#import "SegmentTitleView.h"
#import "CircleListModel.h"
#import "HotPostsModel.h"
#import "HotPostCell.h"
#import "CircelDetailViewController.h"
#import "PostDetailViewController.h"
#import "LoginTableViewController.h"
@interface CircelsViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    AccountModel *account;
    UITableView *circelTableV;
    UITableView *hotTableV;
    NSArray     *circelDataSources;
    NSArray     *hotDataSources;
    NSInteger   segmentIndex;
    UITableView *focusTableV;
}
@property (weak, nonatomic) IBOutlet UILabel *alertStr;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation CircelsViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    account = [AccountModel account];
    if ([account.status isEqualToString:@"YES"]) {
        focusTableV.hidden = YES;
        self.alertStr.text = @"你还没有关注任何人或者你关注的人还没有发布过圈子";
        self.loginBtn.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SegmentTitleView *segmentView = [[SegmentTitleView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, 40) titles:@[@"圈子",@"热贴",@"我关注的"]];
    segmentView.tapLabBack = ^(NSInteger index) {
        
        segmentIndex = index;
        switch (index) {
            case 0:
                circelTableV.hidden = NO;
                hotTableV.hidden = YES;
                focusTableV.hidden = YES;
                [circelTableV.mj_header beginRefreshing];
                break;
            case 1:
                circelTableV.hidden = YES;
                hotTableV.hidden = NO;
                focusTableV.hidden = YES;
                [hotTableV.mj_header beginRefreshing];
                break;
            case 2:
                
                circelTableV.hidden = YES;
                hotTableV.hidden = YES;
                focusTableV.hidden = NO;
                if ([account.status isEqualToString:@"YES"]) {
                    [focusTableV.mj_header beginRefreshing];
                }else {
                    self.alertStr.text = @"当你关注其他人后，他们的最新动态会显示在这里";
                    self.loginBtn.hidden = NO;
                    focusTableV.hidden = YES;
                }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:segmentView];
    
    //圈子
    circelTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-(segmentView.height+49+kStatusBarHeight+kNavigationBarHeight))];
    circelTableV.tableFooterView = [UIView new];
    circelTableV.delegate = self;
    circelTableV.dataSource = self;
    circelTableV.hidden = NO;
    circelTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self circleReloadData];
    }];
    [self.view addSubview:circelTableV];
    [circelTableV.mj_header beginRefreshing];
    
    //热贴
    hotTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-(segmentView.height+49+kStatusBarHeight+kNavigationBarHeight))];
    hotTableV.tableFooterView = [UIView new];
    hotTableV.delegate = self;
    hotTableV.dataSource = self;
    hotTableV.hidden = YES;
    hotTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self hotRequestData];
    }];
    [self.view addSubview:hotTableV];
    
    
    //我关注的
    focusTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-(segmentView.height+49+kStatusBarHeight+kNavigationBarHeight))];
    focusTableV.tableFooterView = [UIView new];
    focusTableV.delegate = self;
    focusTableV.dataSource = self;
    focusTableV.hidden = YES;
    focusTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self performSelector:@selector(endRefresh) withObject:self afterDelay:2];
    }];
    [self.view addSubview:focusTableV];

}

- (IBAction)toLogin:(id)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginTableViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
    UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
    [self presentViewController:loginNavi animated:YES completion:nil];
}

- (void)endRefresh {

    [focusTableV.mj_header endRefreshing];
    focusTableV.hidden = YES;
    self.alertStr.text = @"你还没有关注任何人或者你关注的人还没有发布过圈子";
    self.loginBtn.hidden = YES;
}

- (void)circleReloadData {

    [KSMNetworkRequest postRequest:circleList params:nil success:^(id responseObj) {
        [circelTableV.mj_header endRefreshing];
        NSLog(@"responseObj = %@",responseObj);
        if ([responseObj[@"result"] integerValue] == 100) {
            circelDataSources = [CircleListModel mj_objectArrayWithKeyValuesArray:responseObj[@"boards"]];
            [circelTableV reloadData];
        }
    } failure:^(NSError *error) {
        [circelTableV.mj_header endRefreshing];
    }];
}

- (void)hotRequestData {

    [KSMNetworkRequest postRequest:hotPosts params:nil success:^(id responseObj) {
        
        [hotTableV.mj_header endRefreshing];
        
        NSLog(@"responseObj = %@",responseObj);
        if ([responseObj[@"result"] integerValue] == 100) {
            
            hotDataSources = [HotPostsModel mj_objectArrayWithKeyValuesArray:responseObj[@"posts"]];
            [hotTableV reloadData];
        }
        
    } failure:^(NSError *error) {
        
        [hotTableV.mj_header endRefreshing];
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (segmentIndex) {
        case 0:
            return circelDataSources.count;
            break;
        case 1:
            return hotDataSources.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (segmentIndex == 0) {
        return 60;
    }else {
    
        HotPostsModel *model =  hotDataSources[indexPath.row];
        return model.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (segmentIndex == 0) {
        
        static NSString *reuser = @"circelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuser];
        }
        
        for (UIView *view in cell.contentView.subviews) {
            
            [view removeFromSuperview];
        }
        
        CircleListModel *model = circelDataSources[indexPath.row];
        cell.textLabel.text = model.boardName;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.boardIconUrl] placeholderImage:[UIImage imageNamed:@"3DTouch_jczq"]];
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        
        cell.detailTextLabel.textColor = [UIColor fromHexValue:0x555555];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"人数:%@  帖子:%@",model.peopleNum,model.postsNum];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
    
    if (segmentIndex == 0) {
        CircleListModel *model = circelDataSources[indexPath.row];
        CircelDetailViewController *circelDetail = [CircelDetailViewController new];
        circelDetail.circleListModel = model;
        circelDetail.title = model.boardName;
        circelDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:circelDetail animated:YES];
        
    }else if (segmentIndex == 1) {
    
        HotPostsModel *model = hotDataSources[indexPath.row];
        PostDetailViewController *PostDetailVC = [PostDetailViewController new];
        PostDetailVC.postId = model.postId;
        PostDetailVC.title = @"详情";
        PostDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:PostDetailVC animated:YES];
    }
    

    
}

@end
