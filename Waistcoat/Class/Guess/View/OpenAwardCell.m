//
//  OpenAwardCell.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "OpenAwardCell.h"

@implementation OpenAwardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndex:(NSInteger)index {

    _index = index;
}

-(void)setDic:(NSDictionary *)dic {

    _dic = dic;
    self.avatarW.constant = 0;
    
    self.type.text = dic[@"lotName"];
    self.dateLab.text = [NSString stringWithFormat:@"%@期",dic[@"issue"]];
    
    self.time.text = dic[@"prizeDate"];
    
    
    NSArray *number = [dic[@"award"] componentsSeparatedByString:@","];
    for (int i = 0; i<number.count; i++) {
        
        NSString *str = number[i];
        if ([str rangeOfString:@":"].location != NSNotFound) {
            
            for (int j = 0; j<[str componentsSeparatedByString:@":"].count; j++) {
                
                UILabel *lab = [self.backView2 viewWithTag:i+j+10];
                lab.hidden = NO;
                lab.backgroundColor = [UIColor darkTextColor];
                lab.text = [str componentsSeparatedByString:@":"][j];
            }
        }else {
            
            UILabel *lab = [self.backView2 viewWithTag:i+10];
            lab.hidden = NO;
            lab.backgroundColor = [UIColor orangeColor];
            lab.text = number[i];
        }
    }
}

-(void)setQgDetailModel:(QGDetailModel *)qgDetailModel {

    _qgDetailModel = qgDetailModel;
    
    self.avatarW.constant = 0;
    self.dateLab.text = [NSString stringWithFormat:@"%@期",qgDetailModel.issueId];
    self.time.text = qgDetailModel.htime;
    
    
    
    NSArray *number = [qgDetailModel.lotteryNumber componentsSeparatedByString:@","];
    for (int i = 0; i<number.count; i++) {
        
        NSString *str = number[i];
        if ([str rangeOfString:@":"].location != NSNotFound) {
            
            for (int j = 0; j<[str componentsSeparatedByString:@":"].count; j++) {
                
                UILabel *lab = [self.backView2 viewWithTag:i+j+10];
                lab.hidden = NO;
                lab.backgroundColor = [UIColor darkTextColor];
                lab.text = [str componentsSeparatedByString:@":"][j];
            }
        }else {
            
            UILabel *lab = [self.backView2 viewWithTag:i+10];
            lab.hidden = NO;
            lab.backgroundColor = [UIColor orangeColor];
            lab.text = number[i];
        }
    }
    
}

-(void)setQgModel:(QGModel *)qgModel {

    _qgModel = qgModel;
    
    
    if ([qgModel.lotteryName isEqualToString:@"排列三"]) {
        self.avatar.image = [UIImage imageNamed:@"logo_lnd11_wheelList"];
    }else if ([qgModel.lotteryName isEqualToString:@"排列五"]) {
        self.avatar.image = [UIImage imageNamed:@"logo_hljd11_wheelList"];
    }else if ([qgModel.lotteryName isEqualToString:@"双色球"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoSSQ"];
    }else if ([qgModel.lotteryName isEqualToString:@"福彩3D"]) {
        self.avatar.image = [UIImage imageNamed:@"Logo3D"];
    }else if ([qgModel.lotteryName isEqualToString:@"七星彩"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoQLC"];
    }else if ([qgModel.lotteryName isEqualToString:@"半全场"]) {
        self.avatar.image = [UIImage imageNamed:@"Logo_JCZQ_DCJS"];
    }else if ([qgModel.lotteryName isEqualToString:@"进球彩"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoFootBallJC"];
    }else if ([qgModel.lotteryName isEqualToString:@"胜负彩(任九)"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoKLC"];
    }else if ([qgModel.lotteryName isEqualToString:@"七乐彩"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoQLC"];
    }else if ([qgModel.lotteryName isEqualToString:@"超级大乐透"]) {
        self.avatar.image = [UIImage imageNamed:@"LogoDLT"];
    }else if ([qgModel.lotteryName isEqualToString:@"七乐彩"]) {
        self.avatar.image = [UIImage imageNamed:@"logo_gdd11_wheelList"];
    }else {
        self.avatar.image = [UIImage imageNamed:@"3DTouch_jczq"];
    }
    
    
    self.type.text = qgModel.lotteryName;
    self.dateLab.text = [NSString stringWithFormat:@"%@期",qgModel.ISSUE_ID];
    self.time.text = [qgModel.AWARD_TIME substringToIndex:10];
    
    
    NSArray *number = [qgModel.AWARD_NUMBER componentsSeparatedByString:@","];
    for (int i = 0; i<number.count; i++) {
        
        NSString *str = number[i];
        if ([str rangeOfString:@":"].location != NSNotFound) {
            
            for (int j = 0; j<[str componentsSeparatedByString:@":"].count; j++) {
                
                UILabel *lab = [self.backView2 viewWithTag:i+j+10];
                lab.hidden = NO;
                lab.backgroundColor = [UIColor darkTextColor];
                lab.text = [str componentsSeparatedByString:@":"][j];
            }
        }else {
        
            UILabel *lab = [self.backView2 viewWithTag:i+10];
            lab.hidden = NO;
            lab.backgroundColor = [UIColor orangeColor];
            lab.text = number[i];
        }
    }
}

@end
