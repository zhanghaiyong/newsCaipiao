//
//  BaseTabBarCtrl.m
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "BaseTabBarCtrl.h"
#import "GuessViewController.h"
#import "NewsViewController.h"
#import "CircelsViewController.h"
#import "ProfileViewController.h"
#import "FindTableViewController.h"
@interface BaseTabBarCtrl ()

@end

@implementation BaseTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    AVObject *todoFolder = [AVObject objectWithClassName:@"oneClass"];
    [todoFolder setObject:@"www.baidu.com" forKey:@"url"];// 设置名称
    [todoFolder setObject:@"YES" forKey:@"show"];// 设置优先级
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"保存成功");
        }else {
        
            NSLog(@"失败%@",error);
        }
    }];// 保存到云端
     */
    
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    newsVC.tabBarItem.image = [UIImage imageNamed:@"首页"];
    newsVC.title = @"首页";
    UINavigationController *newsNavi = [[UINavigationController alloc]initWithRootViewController:newsVC];
    
    GuessViewController *GuessVC = [[GuessViewController alloc]init];
    GuessVC.title = @"开奖";
    GuessVC.tabBarItem.image = [UIImage imageNamed:@"开奖"];
    UINavigationController *guessNavi = [[UINavigationController alloc]initWithRootViewController:GuessVC];
    
    FindTableViewController *FindVC = [[FindTableViewController alloc]init];
    FindVC.title = @"发现";
    FindVC.tabBarItem.image = [UIImage imageNamed:@"发现"];
    UINavigationController *FindNavi = [[UINavigationController alloc]initWithRootViewController:FindVC];
    
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    ProfileViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    LoginVC.title = @"我的";
    LoginVC.tabBarItem.image = [UIImage imageNamed:@"我的"];
    UINavigationController *LoginNavi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
    
    self.viewControllers = @[newsNavi,guessNavi,FindNavi,LoginNavi];
    
}



@end
