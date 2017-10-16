//
//  LoadingViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "LoadingViewController.h"
#import "BaseTabBarCtrl.h"
#import "SegmentTitleView.h"
@interface LoadingViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ZHProgressHUD showWithtext:@"加载中..."];
    self.view.backgroundColor = [UIColor whiteColor];
    
    AVQuery *query = [AVQuery queryWithClassName:@"oneClass"];
    __weak LoadingViewController *weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            AVObject *obj = objects[0];
            if ([obj[@"show"] isEqualToString:@"YES"]) {
                
                SegmentTitleView *segmentView = [[SegmentTitleView alloc]initWithFrame:CGRectMake(0, KDeviceHeight-40-kHomeBarHeight, kDeviceWidth, 50) titles:@[@"首页",@"后退",@"前进"]];
                segmentView.hiddenLine = YES;
                segmentView.tapLabBack = ^(NSInteger index) {
                    switch (index) {
                        case 0:
                            [weakSelf.webView reload];
                            break;
                        case 1:
                            [weakSelf.webView goBack];
                            break;
                        case 2:
                            [weakSelf.webView goForward];
                            break;
                        default:
                            break;
                    }
                };
                [weakSelf.view addSubview:segmentView];
                
                weakSelf.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-kHomeBarHeight-50)];
                weakSelf.webView.backgroundColor = [UIColor whiteColor];
                weakSelf.webView.hidden = NO;
                weakSelf.webView.delegate = self;
                weakSelf.webView.scrollView.bounces = NO;
                weakSelf.webView.scrollView.showsVerticalScrollIndicator = NO;
                weakSelf.webView.scrollView.showsHorizontalScrollIndicator = NO;
                NSURL *debugURL=[NSURL URLWithString:obj[@"url"]];
                NSURLRequest *request=[NSURLRequest requestWithURL:debugURL];
                [weakSelf.webView loadRequest:request];
                [weakSelf.view addSubview:weakSelf.webView];
            }else {
              BaseTabBarCtrl *loadingVC = [BaseTabBarCtrl new];
              [UIApplication sharedApplication].keyWindow.rootViewController = loadingVC;
            }
        }else {
            BaseTabBarCtrl *loadingVC = [BaseTabBarCtrl new];
            [UIApplication sharedApplication].keyWindow.rootViewController = loadingVC;
        }
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [ZHProgressHUD dismiss];
    return YES;
}



@end
