//
//  HotDetailCommentModel.h
//  Match
//
//  Created by 张海勇 on 2017/9/30.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDetailCommentModel : NSObject
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *userIp;
@property (nonatomic,strong)NSString *replyCount;
@property (nonatomic,strong)NSString *originId;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *userNickname;
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *parentId;
@property (nonatomic,strong)NSString *userLogo;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *machineCode;
@property (nonatomic,strong)NSString *approveCount;
@property (nonatomic,strong)UIImage *avatar;
@property (nonatomic,assign)CGFloat cellH;
@end
