//
//  PostDetailHead.m
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "PostDetailHead.h"

@implementation PostDetailHead

-(void)setPostDetailModel:(PostDetailModel *)postDetailModel {

    _postDetailModel = postDetailModel;
    
    self.byPost.text = [NSString stringWithFormat:@"发表于:%@",postDetailModel.boardName];
    [self.postImage sd_setImageWithURL:[NSURL URLWithString:postDetailModel.boardUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:postDetailModel.avatarUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.nickLab.text = postDetailModel.nickName;
    self.timeLab.text = postDetailModel.createTime;
    self.content.text = postDetailModel.text;
    
    [self.collectBtn setTitle:[NSString stringWithFormat:@"收藏 %@",postDetailModel.likeCount] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"评论 %@",postDetailModel.commentCount] forState:UIControlStateNormal];
    
    if (postDetailModel.imageList.count > 2) {
        
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = NO;
        
        self.image1Height.constant = 250;
        self.image2Height.constant = 250;
        self.image3Height.constant = 250;
        
        NSDictionary *dic0 = postDetailModel.imageList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:dic0[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dic1 = postDetailModel.imageList[1];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:dic1[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dic2 = postDetailModel.imageList[2];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:dic2[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
    }else if (postDetailModel.imageList.count == 2) {
    
        self.image1.hidden = NO;
        self.image2.hidden = NO;
        self.image3.hidden = YES;
        
        self.image1Height.constant = 250;
        self.image2Height.constant = 250;
        self.image3Height.constant = 0;
        
        NSDictionary *dic0 = postDetailModel.imageList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:dic0[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
        NSDictionary *dic1 = postDetailModel.imageList[1];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:dic1[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if (postDetailModel.imageList.count == 1) {
    
        self.image1.hidden = NO;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        
        self.image1Height.constant = 250;
        self.image2Height.constant = 0;
        self.image3Height.constant = 0;
        
        NSDictionary *dic0 = postDetailModel.imageList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:dic0[@"originalUrl"]] placeholderImage:[UIImage imageNamed:@""]];
        
    }else {
    
        self.image1.hidden = YES;
        self.image2.hidden = YES;
        self.image3.hidden = YES;
        
        self.image1Height.constant = 0;
        self.image2Height.constant = 0;
        self.image3Height.constant = 0;
    }
    
    
    
}

@end
