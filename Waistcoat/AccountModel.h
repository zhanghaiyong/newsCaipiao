//
//  AccountModel.h
//  Guide
//
//  Created by ksm on 16/5/11.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>
@property (nonatomic,strong)NSString *pushStatus;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *pwd;
/**
 *  年龄
 */
@property (nonatomic,strong)NSString *age;
/**
 *  邮箱
 */
@property (nonatomic,strong)NSString *email;
/**
 *  头像
 */
@property (nonatomic,strong)UIImage *avatar;
/**
 *  昵称
 */
@property (nonatomic,strong)NSString *nickname;
/**
 *  手机号
 */
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *account;
/**
 *  性别
 */
@property (nonatomic,strong)NSString *sex;
/**
 *  个性签名
 */
@property (nonatomic,strong)NSString *signature;

+ (void)saveAccount:(AccountModel * __nonnull)account;

+ (AccountModel * __nonnull)account;

+ (void)deleteAccount;

@end
