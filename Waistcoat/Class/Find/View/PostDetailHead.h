//
//  PostDetailHead.h
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostDetailModel.h"
@interface PostDetailHead : UIView
@property (weak, nonatomic) IBOutlet UILabel *byPost;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image3Height;

@property (nonatomic,strong)PostDetailModel *postDetailModel;
@end
