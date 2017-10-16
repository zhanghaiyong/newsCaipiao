//
//  NewsViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/14.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()<UIWebViewDelegate>
@property (strong, nonatomic)UIWebView *webView;
@end



@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ZHProgressHUD showWithtext:@"加载中..."];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-(kStatusBarHeight+kNavigationBarHeight+kHomeBarHeight))];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.hidden = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    NSURL *debugURL=[NSURL URLWithString:KNewsHtml];
    NSURLRequest *request=[NSURLRequest requestWithURL:debugURL];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if (self.webView.hidden) {
        self.webView.hidden = NO;
        [self.webView reload];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [ZHProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    self.webView.hidden = YES;
    [ZHProgressHUD dismiss];
}



@end
