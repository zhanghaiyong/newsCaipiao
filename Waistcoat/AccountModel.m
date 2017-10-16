//
//  AccountModel.m
//  Guide
//
//  Created by ksm on 16/5/11.
//  Copyright © 2016年 ksm. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder  encodeObject:_pushStatus forKey:@"pushStatus"];
    [aCoder  encodeObject:_account forKey:@"account"];
    [aCoder  encodeObject:_status forKey:@"status"];
    [aCoder  encodeObject:_age forKey:@"age"];
    [aCoder  encodeObject:_pwd forKey:@"pwd"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_avatar forKey:@"avatar"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_signature forKey:@"signature"];

}

//解的时候调用，告诉系统哪个属性要解档，如何解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        //一定要赋值
        
        _pushStatus                    = [aDecoder decodeObjectForKey:@"pushStatus"];
        _account                    = [aDecoder decodeObjectForKey:@"account"];
        _status                     = [aDecoder decodeObjectForKey:@"status"];
        _pwd                        = [aDecoder decodeObjectForKey:@"pwd"];
        _age                        = [aDecoder decodeObjectForKey:@"age"];
        _email                      = [aDecoder decodeObjectForKey:@"email"];
        _avatar                     = [aDecoder decodeObjectForKey:@"avatar"];
        _nickname                   = [aDecoder decodeObjectForKey:@"nickname"];
        _phone                      = [aDecoder decodeObjectForKey:@"phone"];
        _sex                        = [aDecoder decodeObjectForKey:@"sex"];
        _signature                  = [aDecoder decodeObjectForKey:@"signature"];

    }
    return self;
}

#pragma mark 保存数据
+ (void)saveAccount:(AccountModel * __nonnull)account {
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
    //保存账号信息：数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
    //好处：以后我不想归档，用数据库，直接改业务类
    [Uitils setUserDefaultsObject:data ForKey:KAccount];
}

#pragma mark  取数据并转模型
+ (AccountModel * __nonnull)account {
    
    NSData *data = [Uitils getUserDefaultsForKey:KAccount];
    if (data) {
        AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return account;
    }else {
    
        return nil;
    }

    
}

+ (void)deleteAccount {
    [Uitils UserDefaultRemoveObjectForKey:KAccount];
}

@end
