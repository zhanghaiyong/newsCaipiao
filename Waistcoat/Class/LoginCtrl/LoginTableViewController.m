//
//  LoginTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/12.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "LoginTableViewController.h"
#import "FindPwdTableViewController.h"
#import "RegisterTableViewController.h"
@interface LoginTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBtn.userInteractionEnabled = NO;
    self.loginBtn.alpha = 0.5;
    self.phoneTF.delegate = self;
    self.pwdTF.delegate = self;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.phoneTF.text.length != 0 && self.pwdTF.text.length != 0) {
        self.loginBtn.userInteractionEnabled = YES;
        self.loginBtn.alpha = 1;
    }else {
        self.loginBtn.userInteractionEnabled = NO;
        self.loginBtn.alpha = 0.5;
    }
    return YES;
}

- (IBAction)backAction:(id)sender {
 
    [self dismissViewControllerAnimated:YES completion:nil];
}

//忘记密码
- (IBAction)findPwdAction:(id)sender {
    
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    FindPwdTableViewController *findPwdVC = [SB instantiateViewControllerWithIdentifier:@"FindPwdTableViewController"];
    [self.navigationController pushViewController:findPwdVC animated:YES];
    
}

//登录
- (IBAction)loginAction:(id)sender {
    
    if (self.phoneTF.text.length != 11) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    [SVProgressHUD show];
    AccountModel *model = [AccountModel account];
    if ([model.account isEqualToString:self.phoneTF.text] && [model.pwd isEqualToString:self.pwdTF.text]) {
        
        model.status = @"YES";
        [AccountModel saveAccount:model];
        [SVProgressHUD showWithStatus:@"登录中..."];
        [self performSelector:@selector(delayBack) withObject:self afterDelay:3];
        
    //默认帐号
    }else if([self.phoneTF.text isEqualToString:@"18380317172"] && [self.pwdTF.text isEqualToString:@"123456"]){
        
        AccountModel *defaultModel = [[AccountModel alloc]init];
        defaultModel.account = self.phoneTF.text;
        defaultModel.pwd = self.pwdTF.text;
        defaultModel.status = @"YES";
        UIImage *avatar = [UIImage imageNamed:@"icon_head_default_iphone"];
        defaultModel.avatar = avatar;
        [AccountModel saveAccount:defaultModel];
        [SVProgressHUD showWithStatus:@"登录中..."];
        [self performSelector:@selector(delayBack) withObject:self afterDelay:3];
    }else {
        [SVProgressHUD showErrorWithStatus:@"手机号或密码错误！"];
    }
}

- (void)delayBack {
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//去注册
- (IBAction)registerAction:(id)sender {

    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RegisterTableViewController *registerVC = [SB instantiateViewControllerWithIdentifier:@"RegisterTableViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];


}

@end
