//
//  CircelNoticeViewController.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "CircelNoticeViewController.h"

@interface CircelNoticeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end

@implementation CircelNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.model.avatarUrl] placeholderImage:nil];
    self.nick.text = self.model.nickName;
    self.time.text = self.model.createTime;
//    
//    CGRect frame = [self.model.text boundingRectWithSize:CGSizeMake(kDeviceWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:18]} context:nil];
//    
//    self.contentH.constant = frame.size.height;
    self.contentView.text = self.model.text;
}



@end
