//
//  GuessViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "GuessViewController.h"
#import "SegmentTitleView.h"
#import "QGModel.h"
#import "OpenAwardCell.h"
#import "OpenAwardDetailViewController.h"
@interface GuessViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *QGTableView;
    NSArray *QGDataSource;
    
    UITableView *OTableView;
    NSArray *OTitleArr;
    NSDictionary *ODataSource;
    NSMutableArray *fold;
    NSInteger segIndex;
}

@end

@implementation GuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    fold = [NSMutableArray array];
    SegmentTitleView *segmentView = [[SegmentTitleView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, 40) titles:@[@"全部",@"省份",@"高概率"]];
    segmentView.tapLabBack = ^(NSInteger index) {
        segIndex = index;
        
        switch (index) {
            case 0:
                QGTableView.hidden = NO;
                OTableView.hidden = YES;
                [QGTableView reloadData];
                break;
            case 1:
                QGTableView.hidden = YES;
                OTableView.hidden = NO;
                [self OReloadData:KOpenPrizeDF];
                break;
            case 2:
                QGTableView.hidden = YES;
                OTableView.hidden = NO;
                [self OReloadData:KOpenPrizeGP];
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:segmentView];
    
    
    //全国
    QGTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-segmentView.height-kHomeBarHeight)];
    QGTableView.tableFooterView = [UIView new];
    QGTableView.delegate = self;
    QGTableView.dataSource = self;
    QGTableView.hidden = NO;
    QGTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self QGReloadData];
    }];
    [self.view addSubview:QGTableView];
    [QGTableView.mj_header beginRefreshing];
    
    //地方-高频
    OTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, segmentView.bottom, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-segmentView.height-kHomeBarHeight)];
    OTableView.tableFooterView = [UIView new];
    OTableView.clipsToBounds = YES;
    OTableView.delegate = self;
    OTableView.dataSource = self;
    OTableView.hidden = YES;
    OTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (segIndex == 1) {
        
            [self OReloadData:KOpenPrizeDF];
        }else {
            [self OReloadData:KOpenPrizeGP];
        }
        
    }];
    [self.view addSubview:OTableView];
}


- (void)QGReloadData {

    [KSMNetworkRequest postRequest:KOpenPrizeQG params:nil success:^(id responseObj) {
        [QGTableView.mj_header endRefreshing];
        if ([responseObj[@"code"] integerValue] == 3001) {
            
            QGDataSource = [QGModel mj_objectArrayWithKeyValuesArray:responseObj[@"datas"]];
            [QGTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [QGTableView.mj_header endRefreshing];
    }];
}


- (void)OReloadData:(NSString *)url {
    
    [KSMNetworkRequest postRequest:url params:nil success:^(id responseObj) {
        [OTableView.mj_header endRefreshing];
        if ([responseObj[@"code"] integerValue] == 3001) {
            
            OTitleArr = [responseObj[@"province"] componentsSeparatedByString:@","];
            
            for (NSString *str in OTitleArr) {
                [fold addObject:@"NO"];
            }
            
            ODataSource = responseObj[@"datas"];
            [OTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [OTableView.mj_header endRefreshing];
    }];
}

#pragma mark UITableViewDelegate

//sectionCount
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (segIndex == 0) {
        
        return 1;
    }
    return OTitleArr.count;
}

//rowCount
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (segIndex == 0) {
        
        return QGDataSource.count;
    }
    
    if ([fold[section] isEqualToString:@"NO"]) {
        return 0;
    }else {
        NSString *key = OTitleArr[section];
        NSArray *arr = [ODataSource objectForKey:key];
        return arr.count;
    }
}

//cellH
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

//footHeight
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.1;
}

//headHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (segIndex == 0) {
        
        return 0.1;
    }
    return 40;
}


//headView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (segIndex == 0) {
        return nil;
    }
    
    UIButton  *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    button.tag = 100+section;
    [button addTarget:self action:@selector(foldClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = OTitleArr[section];
    [button addSubview:titleLab];
    
    UILabel *imageLab = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-40, 5, 30, 30)];
    imageLab.font = [UIFont boldSystemFontOfSize:20];
    imageLab.tag = 1000;
    if ([fold[section] isEqualToString:@"NO"]) {
        imageLab.text = @"↓";
    }else {
    
        imageLab.text = @"↑";
    }
    imageLab.textAlignment = NSTextAlignmentCenter;
    [button addSubview:imageLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor fromHexValue:0xEBEBEB];
    [button addSubview:line];
    
    return button;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (segIndex == 0) {
        
        static NSString *reuser = @"HotCell";
        OpenAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OpenAwardCell" owner:self options:nil] lastObject];
        }
        QGModel *model = QGDataSource[indexPath.row];
        cell.index = indexPath.row;
        cell.qgModel = model;
        
        return cell;
    }else {
        
        static NSString *reuser = @"OtherCell";
        OpenAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OpenAwardCell" owner:self options:nil] lastObject];
        }
        
        NSString *key = OTitleArr[indexPath.section];
        NSArray *arr = [ODataSource objectForKey:key];
        NSDictionary *dic = arr[indexPath.row];
        cell.dic = dic;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OpenAwardDetailViewController *detailVC = [OpenAwardDetailViewController new];
    detailVC.segIndex = segIndex;
    if (segIndex == 0) {
        
        QGModel *model = QGDataSource[indexPath.row];
        detailVC.title = model.lotteryName;
        detailVC.index = indexPath.row;
        detailVC.url = KOpenPrizeQGDetail;
        detailVC.lotteryNo = [NSString stringWithFormat:@"&playid=%@",model.lotteryNo];

    }else if (segIndex == 1) {
        NSString *key = OTitleArr[indexPath.section];
        NSArray *arr = [ODataSource objectForKey:key];
        NSDictionary *dic = arr[indexPath.row];
        detailVC.title = dic[@"lotName"];
        detailVC.url = KOpenPrizeDFDetail;
        detailVC.index = 4;
        detailVC.lotteryNo = [NSString stringWithFormat:@"&lotid=%@",dic[@"lotId"]];
    }else {
    
        NSString *key = OTitleArr[indexPath.section];
        NSArray *arr = [ODataSource objectForKey:key];
        NSDictionary *dic = arr[indexPath.row];
        detailVC.title = dic[@"lotName"];
        detailVC.url = KOpenPrizeGPDetail;
        detailVC.index = 4;
        detailVC.lotteryNo = [NSString stringWithFormat:@"&lotid=%@&prizeDate=%@",dic[@"lotId"],dic[@"prizeDate"]];
    }
    
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)foldClick:(UIButton  *)sender {

    
    UILabel *imageLab = (UILabel *)[sender viewWithTag:1000];
    if ([fold[sender.tag-100] isEqualToString:@"NO"]) {
        
        [fold replaceObjectAtIndex:sender.tag-100 withObject:@"YES"];
        imageLab.text = @"↑";
    }else {
    
        [fold replaceObjectAtIndex:sender.tag-100 withObject:@"NO"];
        imageLab.text = @"↓";
    }
    
    [OTableView reloadData];
}



@end
