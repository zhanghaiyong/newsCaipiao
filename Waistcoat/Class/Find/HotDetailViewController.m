//
//  HotDetailViewController.m
//  Match
//
//  Created by 张海勇 on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotDetailViewController.h"
#import "HotDetailCommentModel.h"
#import "HotDetailCommentCell.h"
#import "CommentView.h"
#import "WriteCommentView.h"
#import "LoginTableViewController.h"
@interface HotDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    CGFloat webViewH;
    UITableView *tableView;
    NSDictionary *htmlDict;
    NSMutableArray *commentArr;
    UIButton *sharebtn;
    
    
}
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)WriteCommentView *writeView;
@property (nonatomic,strong)AccountModel *account;
@property (nonatomic,strong)CommentView *commentView;
@end

@implementation HotDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    
    self.account = [AccountModel account];
    if (self.commentView) {
        if ([self.account.status isEqualToString:@"YES"]) {
            [self.commentView.tapToCommentBtn setTitle:@"   写评论" forState:UIControlStateNormal];
        }else {
            [self.commentView.tapToCommentBtn setTitle:@"   登录后写评论" forState:UIControlStateNormal];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.account = [AccountModel account];

    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    webViewH = 200;
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight-40)];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-kStatusBarHeight-kNavigationBarHeight-kHomeBarHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    
    tableView.tableHeaderView = _webView;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    [self.view addSubview:tableView];
    [tableView.mj_header beginRefreshing];
    
    
    __weak HotDetailViewController *weakSelf = self;
    self.commentView = [[[NSBundle mainBundle] loadNibNamed:@"CommentView" owner:self options:nil] lastObject];
    self.commentView.frame = CGRectMake(0, KDeviceHeight-kHomeBarHeight-40, kDeviceWidth, 40);
    self.commentView.shareNewsBack = ^{ //分享
        
        UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[weakSelf.newsTitle, htmlDict[@"content"]] applicationActivities:nil];
        [weakSelf presentViewController:activity animated:YES completion:nil];
    };
    self.commentView.commentBack = ^{ //去评论
        
        if ([weakSelf.account.status isEqualToString:@"YES"]) {
            [weakSelf.writeView.contentTV becomeFirstResponder];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录解锁更多内容" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"登录/注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                LoginTableViewController *LoginVC = [SB instantiateViewControllerWithIdentifier:@"LoginTableViewController"];
                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:LoginVC];
                [weakSelf presentViewController:navi animated:YES completion:nil];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    };
    [self.view addSubview:self.commentView];
    
    self.writeView = [[[NSBundle mainBundle] loadNibNamed:@"WriteCommentView" owner:self options:nil] lastObject];
    self.writeView.frame = CGRectMake(0, KDeviceHeight, kDeviceWidth, 140);
    self.writeView.cancelReleaseBack = ^{
        [weakSelf.writeView.contentTV resignFirstResponder];
    };
    self.writeView.ReleaseBack = ^{
        
        if (weakSelf.writeView.contentTV.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"说点什么吧！"];
            return ;
        }
        HotDetailCommentModel *model = [[HotDetailCommentModel alloc]init];
        model.avatar = weakSelf.account.avatar; //头像
        model.userNickname = weakSelf.account.nickname;//昵称
        model.content = weakSelf.writeView.contentTV.text;//评论
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
        model.createTime = timeString;//时间
        model.approveCount = @"0";//评论数
        [commentArr addObject:model];
        [tableView reloadData];
        [weakSelf.writeView.contentTV resignFirstResponder];
        
        [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
    };
    [self.view addSubview:self.writeView];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // 获取通知的信息字典
    NSDictionary *userInfo = [aNotification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.writeView.frame = CGRectMake(0, KDeviceHeight-kHomeBarHeight-keyboardRect.size.height-140, kDeviceWidth, 140);
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // 获取通知的信息字典
    NSDictionary *userInfo = [aNotification userInfo];
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.writeView.frame = CGRectMake(0, KDeviceHeight, kDeviceWidth, 140);
    }];
}

- (void)refreshData {
    
    [SVProgressHUD show];
    
    [KSMNetworkRequest getRequest:[NSString stringWithFormat:@"%@&nid=%@",kHotDetail,self.newsId] params:nil success:^(id responseObj) {
        
        [SVProgressHUD dismiss];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            htmlDict = [NSDictionary dictionaryWithDictionary:responseObj[@"data"]];
            
            [self.webView loadHTMLString:responseObj[@"data"][@"content"] baseURL:nil];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
    
    [KSMNetworkRequest getRequest:[NSString stringWithFormat:@"%@&originId=%@",kHotDetailComment,self.newsId] params:nil success:^(id responseObj) {
        [tableView.mj_header endRefreshing];
        if ([responseObj[@"error_code"] integerValue] == 1) {
            commentArr = [HotDetailCommentModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"newList"]];
            [tableView reloadData];
        }
    } failure:^(NSError *error) {
        [tableView.mj_header endRefreshing];
        return;
    }];

}

#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)wb
{
    
    sharebtn.selected = YES;
    NSString *height_str = [wb stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    //document.body.offsetHeight获取页面高度信息
    int temp = (int)height_str.integerValue - 44;
    _webView.frame = CGRectMake(0, 0, kDeviceWidth, temp);
    _webView.scrollView.scrollEnabled = NO;  //禁止滚动
    [tableView reloadData];
}

#pragma mark UITableViewDelegate

//sectionCount
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//rowCount
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return commentArr.count;
}

//cellH
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotDetailCommentModel *model = commentArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuser = @"hotComment";
    HotDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotDetailCommentCell" owner:self options:nil] lastObject];
    }
    HotDetailCommentModel *model = commentArr[indexPath.row];
    if (model.userLogo.length == 0) {
        cell.avatar.image = model.avatar;
    }else {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:model.userLogo] placeholderImage:[UIImage imageNamed:@"hall_ad_placeholder"]];
    }
    cell.nickLab.text = model.userNickname;
    cell.timeLab.text = [Uitils timeWithTimeIntervalString:model.createTime];
    [cell.TagLab setTitle:[NSString stringWithFormat:@"✯%@",model.approveCount] forState:UIControlStateNormal];
    cell.commentLab.text = model.content;
    
    return cell;
}



@end
