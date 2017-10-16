//
//  OpenAwardCell.h
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGModel.h"
#import "QGDetailModel.h"
@interface OpenAwardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarW;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@property (nonatomic,strong)QGModel *qgModel;

@property (nonatomic,strong)QGDetailModel *qgDetailModel;

@property (nonatomic,strong)NSDictionary *dic;

@property (nonatomic,assign)NSInteger index;
@end
