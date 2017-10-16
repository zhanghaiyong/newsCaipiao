//
//  PostDetailCell.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "PostDetailCell.h"

@implementation PostDetailCell


-(void)setDic:(NSDictionary *)dic {

    _dic = dic;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:dic[@"replyerAvatarUrl"]] placeholderImage:nil];
    self.name.text = dic[@"replyerNickName"];
    self.time.text = dic[@"createTime"];
    self.floor.text = [NSString stringWithFormat:@"%@楼",dic[@"floor"]];
    self.content.text = dic[@"text"];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
