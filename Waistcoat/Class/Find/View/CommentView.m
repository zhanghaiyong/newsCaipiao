//
//  CommentView.m
//  Match
//
//  Created by zhy on 2017/10/13.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)commentAction:(UIButton *)sender {
    
    if (_commentBack) {
        _commentBack();
    }
    
}
- (IBAction)collectAction:(UIButton *)sender {
    
    AccountModel *model = [AccountModel account];
    //有帐号
    if ([model.status isEqualToString:@"YES"]) {
        if (sender.selected) {
            sender.selected = NO;
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
        }else {
            sender.selected = YES;
            [SVProgressHUD showSuccessWithStatus:@"已收藏"];
        }
    }else {
        [SVProgressHUD showInfoWithStatus:@"登录后可收藏"];
    }
    

}
- (IBAction)shareAction:(UIButton *)sender {
    
    if (_shareNewsBack) {
        _shareNewsBack();
    }
}

@end
