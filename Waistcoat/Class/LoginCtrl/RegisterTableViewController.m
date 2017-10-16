//
//  RegisterTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/12.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "LoginTableViewController.h"
@interface RegisterTableViewController ()<UITextFieldDelegate>
{
    NSTimer *time;
    NSInteger cutDownCount;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@end

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    self.registerBtn.userInteractionEnabled = NO;
    self.registerBtn.alpha = 0.5;
    self.phoneTF.delegate = self;
    self.codeTF.delegate = self;
    self.pwdTF.delegate = self;
    cutDownCount = 60;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.phoneTF.text.length != 0 && self.pwdTF.text.length != 0 && self.codeTF.text.length != 0) {
        self.registerBtn.userInteractionEnabled = YES;
        self.registerBtn.alpha = 1;
    }else {
        self.registerBtn.userInteractionEnabled = NO;
        self.registerBtn.alpha = 0.5;
    }
    return YES;
}

- (IBAction)getCodeAction:(id)sender {
    
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    //获取验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功！"];
            // 请求成功
            time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cutDown:) userInfo:nil repeats:YES];
        }
        else
        {
            NSLog(@"%@",error.localizedDescription);
            // error
            [SVProgressHUD showErrorWithStatus:@"获取失败，请重试！"];
        }
    }];
}

- (void)cutDown:(NSTimer *)timer {
    
    self.getCodeBtn.userInteractionEnabled = NO;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%lds",cutDownCount] forState:UIControlStateNormal];
    cutDownCount --;
    
    if (cutDownCount == 0) {
        
        self.getCodeBtn.userInteractionEnabled = YES;
        cutDownCount = 60;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [time invalidate];
        time = nil;
    }
}

- (IBAction)registerAction:(id)sender {
    
    [SVProgressHUD show];
    //验证
    [SMSSDK commitVerificationCode:self.codeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            
            AccountModel *model = [[AccountModel alloc]init];
            model.account = self.phoneTF.text;
            model.pwd = self.pwdTF.text;
            UIImage *avatar = [UIImage imageNamed:@"icon_head_default_iphone"];
            model.avatar = avatar;
            [AccountModel saveAccount:model];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        }
        else
        {
            // error
            self.getCodeBtn.userInteractionEnabled = YES;
            cutDownCount = 60;
            [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [time invalidate];
            time = nil;
            [SVProgressHUD showErrorWithStatus:@"验证码错误"];
            return ;
        }
    }];
}

- (IBAction)toLoginAction:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkPwdAction:(id)sender {
    
    if (self.showBtn.selected) {
        self.showBtn.selected = NO;
        self.pwdTF.secureTextEntry = YES;
    }else {
        self.showBtn.selected = YES;
        self.pwdTF.secureTextEntry = NO;
    }
    
}

@end
