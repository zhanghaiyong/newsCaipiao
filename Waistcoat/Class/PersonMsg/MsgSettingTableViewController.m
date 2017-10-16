//
//  MsgSettingTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "MsgSettingTableViewController.h"

@interface MsgSettingTableViewController ()
{
    AccountModel *model;
}
@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@end

@implementation MsgSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    model = [AccountModel account];
    
    if ([self.title isEqualToString:@"修改昵称"]) {
        self.contentTF.placeholder = @"请输入昵称";
        self.contentTF.text = model.nickname;
    }else if ([self.title isEqualToString:@"修改手机号"]) {
        self.contentTF.placeholder = @"请输入手机号码";
        self.contentTF.text = model.account;
    }else if ([self.title isEqualToString:@"修改邮箱"]) {
        self.contentTF.placeholder = @"请输入邮箱";
        self.contentTF.text = model.email;
    }
}

- (IBAction)SubmitAction:(id)sender {
    
    if (self.contentTF.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    if ([self.title isEqualToString:@"修改昵称"]) {
        model.nickname = self.contentTF.text;
    }else if ([self.title isEqualToString:@"修改手机号"]) {
        model.account = self.contentTF.text;
    }else if ([self.title isEqualToString:@"修改邮箱"]) {
        model.email = self.contentTF.text;
    }
    [AccountModel saveAccount:model];
    
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
