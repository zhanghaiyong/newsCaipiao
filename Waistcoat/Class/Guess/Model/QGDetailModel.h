//
//  QGDetailModel.h
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QGDetailModel : NSObject<MJKeyValue>

@property (nonatomic,strong)NSString *lotteryId;
@property (nonatomic,strong)NSString *lotteryNumber;
@property (nonatomic,strong)NSString *issue;
@property (nonatomic,strong)NSString *lotteryName;
@property (nonatomic,strong)NSString *htime;
@property (nonatomic,strong)NSString *playid;
@property (nonatomic,strong)NSString *lotId;
@property (nonatomic,strong)NSString *issueId;

@end
