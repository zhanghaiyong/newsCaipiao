//
//  SettingTableViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/20.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()
{
    AccountModel *model;
}
@property (weak, nonatomic) IBOutlet UILabel *cacheLab;
@property (weak, nonatomic) IBOutlet UISwitch *pushswitch;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    model = [AccountModel account];
    self.pushswitch.on = [model.pushStatus boolValue];

    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    self.cacheLab.text = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];

}
//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size {
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}


- (IBAction)pushHandClick:(UISwitch *)sender {
    
    if (!sender.isOn) {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        model.pushStatus = @"NO";
    }else {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        model.pushStatus = @"YES";
    }

    [AccountModel saveAccount:model];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 1) {
        
        [[SDImageCache sharedImageCache]clearMemory];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
            [ZHProgressHUD showSuccessWithText:@"清除成功"];
        }];
        self.cacheLab.text = @"0";
    }
}


@end
