//
//  ProfileViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "ProfileViewController.h"
#import <SDWebImage/NSImage+WebCache.h>
#import "DealCodeViewController.h"
#import "FeedbackViewController.h"
#import "TakePhotoViewController.h"
#import "LoginTableViewController.h"
#import "PersonMsgTableViewController.h"
@interface ProfileViewController ()
{
    AccountModel *account;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@end

@implementation ProfileViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    account = [AccountModel account];
    
    //判断是否登录
    if ([account.status isEqualToString:@"YES"]) {
        self.arrowImg.hidden = NO;
        self.avatar.image = account.avatar;
        //设置了昵称
        if (account.nickname.length != 0) {
            [self.loginBtn setTitle:account.nickname forState:UIControlStateNormal];
        }else {//否则显示手机号
            [self.loginBtn setTitle:account.account forState:UIControlStateNormal];
        }
    }else {
        [self.loginBtn setTitle:@"请登录" forState:UIControlStateNormal];
        self.arrowImg.hidden = YES;
        self.avatar.image = [UIImage imageNamed:@"icon_head_default_iphone"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setAvatar)];
    [self.avatar addGestureRecognizer:tap];
    self.tableView.tableFooterView = [UIView new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([account.status isEqualToString:@"YES"]) {
        
        switch (indexPath.row) {
            case 0: //个人信息
            {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"PersonMsg" bundle:nil];
                PersonMsgTableViewController *personMsgVC = [SB instantiateViewControllerWithIdentifier:@"PersonMsgTableViewController"];
                personMsgVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:personMsgVC animated:YES];
            }
                break;
            case 1: //交易记录
            {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
                DealCodeViewController *dealCodeVC = [SB instantiateViewControllerWithIdentifier:@"DealCodeViewController"];
                dealCodeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:dealCodeVC animated:YES];
            }
                break;
            case 2: //反馈
            {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
                FeedbackViewController *FeedbackVC = [SB instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
                FeedbackVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:FeedbackVC animated:YES];
            }
                break;
            default:
                break;
        }
    }else {
        if (indexPath.row != 3) {
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            LoginTableViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
            UINavigationController *loginNavi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
            [self presentViewController:loginNavi animated:YES completion:nil];
        }
    }
    
}


- (void)setAvatar {

    TakePhotoViewController *takePhotoVC = [[TakePhotoViewController alloc]init];
    [takePhotoVC returnImage:^(UIImage *image) {
        
        self.avatar.image = image;
        account.avatar = image;
        [AccountModel saveAccount:account];
    }];
    [self presentViewController:takePhotoVC animated:YES completion:nil];
}





@end
