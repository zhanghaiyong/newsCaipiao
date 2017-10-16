//
//  HotPostsModel.h
//  Waistcoat
//
//  Created by zhy on 2017/9/15.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotPostsModel : NSObject
@property (nonatomic,strong)NSString *boardId;
@property (nonatomic,strong)NSString *avatarUrl;

@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *showTag;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *nickName;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *istop;
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *like;
@property (nonatomic,strong)NSString *likeCount;
@property (nonatomic,strong)NSString *commentCount;
@property (nonatomic,strong)NSString *postId;
@property (nonatomic,strong)NSString *boardName;
@property (nonatomic,strong)NSString *shareUrl;
@property (nonatomic,strong)NSArray  *imageList;
@property (nonatomic,strong)NSDictionary *sharePage;
@property (nonatomic,strong)NSString *followState;

@property (nonatomic,strong)NSString *collectStatus;
@property (nonatomic,strong)NSString *boardUrl;
@property (nonatomic,strong)NSString *accountId;
@property (nonatomic,strong)NSArray  *comments;

@property (nonatomic,assign)CGFloat cellHeight;
@end
