//
//  QGDetailModel.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "QGDetailModel.h"

@implementation QGDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {

    return @{@"lotteryNumber":@"award",@"issueId":@"prizeDate",@"htime":@"createTime"};
}

@end
