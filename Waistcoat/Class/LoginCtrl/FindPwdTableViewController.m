//
//  FindPwdTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/12.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FindPwdTableViewController.h"

@interface FindPwdTableViewController ()<UITextFieldDelegate>
{
    NSTimer *time;
    NSInteger cutDownCount;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdOfNewTF;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;


@end

@implementation FindPwdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    self.phoneTF.delegate = self;
    self.codeTF.delegate = self;
    self.pwdOfNewTF.delegate = self;
    self.sureBtn.userInteractionEnabled = NO;
    self.sureBtn.alpha = 0.5;
    cutDownCount = 60;
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.phoneTF.text.length != 0 && self.pwdOfNewTF.text.length != 0 && self.codeTF.text.length != 0) {
        self.sureBtn.userInteractionEnabled = YES;
        self.sureBtn.alpha = 1;
    }else {
        self.sureBtn.userInteractionEnabled = NO;
        self.sureBtn.alpha = 0.5;
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

-(void)cutDown:(NSTimer *)timer {
    
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

- (IBAction)submitAction:(id)sender {
    
    [SVProgressHUD show];
    //验证
    [SMSSDK commitVerificationCode:self.codeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            AccountModel *model = [AccountModel account];
            model.pwd = self.pwdOfNewTF.text;
            [AccountModel saveAccount:model];
            [SVProgressHUD showSuccessWithStatus:@"重置成功"];
            [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)checkPwdAction:(id)sender {
    
    if (self.showBtn.selected) {
        self.showBtn.selected = NO;
        self.pwdOfNewTF.secureTextEntry = YES;
    }else {
        self.showBtn.selected = YES;
        self.pwdOfNewTF.secureTextEntry = NO;
    }
}


@end
