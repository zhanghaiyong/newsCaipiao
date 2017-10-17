//
//  FindTableViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/10/17.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FindTableViewController.h"
#import "CircelsViewController.h"
#import "PersonViewController.h"
@interface FindTableViewController ()

@end

@implementation FindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [UIView new];
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuser = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuser];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"资讯"];
            cell.textLabel.text = @"资讯";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"圈子"];
            cell.textLabel.text = @"圈子";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            PersonViewController *newsVC = [[PersonViewController alloc]init];
            newsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newsVC animated:YES];
        }
            break;
        case 1:
        {
            CircelsViewController *circleVC = [[CircelsViewController alloc]init];
            circleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:circleVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
