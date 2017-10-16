//
//  FeedbackViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帮助与反馈";
}
- (IBAction)submitClick:(id)sender {
    
    if (self.phoneTF.text.length == 0) {
        
        [ZHProgressHUD showInfoWithText:@"请输入手机号,我们将及时联系你"];
        return;
    }
    
    if (self.contentTV.text.length == 0) {
        [ZHProgressHUD showInfoWithText:@"对我们说点什么吧"];
        return;
    }
    
    [ZHProgressHUD show];
    [self performSelector:@selector(submitSuccess) withObject:self afterDelay:3];
    
}

- (void)submitSuccess {

    [ZHProgressHUD showSuccessWithText:@"感谢你的意见！"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
