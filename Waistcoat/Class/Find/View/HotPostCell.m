//
//  HotPostCell.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "HotPostCell.h"

@implementation HotPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHotPostsModel:(HotPostsModel *)hotPostsModel {

    _hotPostsModel = hotPostsModel;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:hotPostsModel.avatarUrl]];
    self.nickLab.text = hotPostsModel.nickName;
    self.byPost.text = [NSString stringWithFormat:@"发表于%@",hotPostsModel.boardName];
    self.content.text = hotPostsModel.text;
    self.timeLab.text = hotPostsModel.createTime;
    
    [self.collectBtn setTitle:[NSString stringWithFormat:@"收藏 %@",hotPostsModel.likeCount] forState:UIControlStateNormal];
    [self.commonBtn setTitle:[NSString stringWithFormat:@"评论 %@",hotPostsModel.commentCount] forState:UIControlStateNormal];
    
    if (hotPostsModel.imageList.count > 1) {
        
        self.bigImagr.hidden = YES;
        self.timeTop.constant = 110;
        
        if (hotPostsModel.imageList.count == 2) {
            
            self.image1.hidden = NO;
            self.image2.hidden = NO;
            self.image3.hidden = YES;
            
            NSDictionary *dic0 = hotPostsModel.imageList[0];
            [self.image1 sd_setImageWithURL:[NSURL URLWithString:dic0[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
            
            NSDictionary *dic1 = hotPostsModel.imageList[1];
            [self.image2 sd_setImageWithURL:[NSURL URLWithString:dic1[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        }else {
        
            self.image1.hidden = NO;
            self.image2.hidden = NO;
            self.image3.hidden = NO;
            
            NSDictionary *dic0 = hotPostsModel.imageList[0];
            [self.image1 sd_setImageWithURL:[NSURL URLWithString:dic0[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
            
            NSDictionary *dic1 = hotPostsModel.imageList[1];
            [self.image2 sd_setImageWithURL:[NSURL URLWithString:dic1[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
            
            NSDictionary *dic2 = hotPostsModel.imageList[2];
            [self.image3 sd_setImageWithURL:[NSURL URLWithString:dic2[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        }
    }else if(hotPostsModel.imageList.count == 1){
    
        self.bigImagr.hidden = NO;
        self.timeTop.constant = 150;
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        
        NSDictionary *dic0 = hotPostsModel.imageList[0];
        [self.bigImagr sd_setImageWithURL:[NSURL URLWithString:dic0[@"thumbnailUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }else {
    
        self.bigImagr.hidden = YES;
        self.timeTop.constant = 0;
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
    }
    
    
}



@end
