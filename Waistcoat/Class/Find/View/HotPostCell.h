//
//  HotPostCell.h
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotPostsModel.h"
@interface HotPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickLab;
@property (weak, nonatomic) IBOutlet UILabel *byPost;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *bigImagr;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *commonBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTop;

@property (nonatomic,strong)HotPostsModel *hotPostsModel;

@end
