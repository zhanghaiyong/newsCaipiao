//
//  SignTableViewController.m
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "SignTableViewController.h"

@interface SignTableViewController ()<UITextViewDelegate>
{
    AccountModel *model;
}
@property (weak, nonatomic) IBOutlet UITextView *signContent;

@end

@implementation SignTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    model = [AccountModel account];
    self.signContent.text = model.signature;
    self.signContent.delegate = self;
}

#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 60) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 20)];
        [textView.undoManager removeAllActions];
        return;
    }
}


- (IBAction)submitAction:(id)sender {
    
    if (self.signContent.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    model.signature = self.signContent.text;
    [AccountModel saveAccount:model];
    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
