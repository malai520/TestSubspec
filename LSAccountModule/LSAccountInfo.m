//
//  LSAccountInfo.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSAccountInfo.h"

NSString *kLSAccountUserTypeKey = @"userType";
NSString *kLSAccountAccessTokenKey = @"accessToken";
NSString *kLSAccountUserIdKey = @"userId";
NSString *kLSAccountExpireAtKey = @"expireAt";
NSString *kLSAccountLoginIdKey = @"loginId";
NSString *kLSAccountAppTypeKey = @"appType";

@interface LSAccountInfo ()

@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSNumber *expireAt;

@property (nonatomic, copy) NSNumber *userType;

@end

@implementation LSAccountInfo

//对变量编码
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.accessToken forKey:kLSAccountAccessTokenKey];
    [coder encodeObject:self.expireAt forKey:kLSAccountExpireAtKey];
    [coder encodeObject:self.userId forKey:kLSAccountUserIdKey];
    [coder encodeObject:self.userType forKey:kLSAccountUserTypeKey];
}

//对变量解码
- (id)initWithCoder:(NSCoder *)coder {
    if (coder == nil) {
        return nil;
    }
    
    self.accessToken = [coder decodeObjectForKey:kLSAccountAccessTokenKey];
    self.expireAt = [coder decodeObjectForKey:kLSAccountExpireAtKey];
    self.userId = [coder decodeObjectForKey:kLSAccountUserIdKey];
    self.userType = [coder decodeObjectForKey:kLSAccountUserTypeKey];
    return self;
}

+ (instancetype)accountInfoWithDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    
    LSAccountInfo *accountInfo = [[LSAccountInfo alloc] init];
    accountInfo.accessToken = dic[kLSAccountAccessTokenKey];
    accountInfo.userId = [NSString stringWithFormat:@"%@",dic[kLSAccountUserIdKey]];
    accountInfo.expireAt = dic[kLSAccountExpireAtKey];
    accountInfo.userType = dic[kLSAccountUserTypeKey];
    
    if (accountInfo.accessToken.length > 0
        && accountInfo.userId.length > 0
        && accountInfo.expireAt) {
        return accountInfo;
    }
    
    NSAssert(NO, @"登陆返回的数据有错误!!!!");
    
    return nil;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[LSAccountInfo class]]) {
        LSAccountInfo *accountInfo = object;
        if ([accountInfo.userId isEqualToString:self.userId]
            && [accountInfo.userType isEqualToNumber:self.userType]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"accessToken:%@\nuserId:%@\nexpireAt:%@\nuserType:%@",self.accessToken,self.userId,self.expireAt,self.userType];
}

@end


@implementation LSCookieAccountInfo

+ (instancetype)accountInfoWithDictionary:(NSDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    
    LSCookieAccountInfo *accountInfo = [[LSCookieAccountInfo alloc] init];
    accountInfo.accessToken = dic[kLSAccountAccessTokenKey];
    accountInfo.userId = dic[kLSAccountLoginIdKey];
    accountInfo.expireAt = dic[kLSAccountExpireAtKey];
    accountInfo.userType = dic[kLSAccountUserTypeKey];
    accountInfo.appType = dic[kLSAccountAppTypeKey];
    
    if (accountInfo.accessToken.length > 0
        && accountInfo.userId.length > 0
        && accountInfo.expireAt) {
        return accountInfo;
    }
    
    NSAssert(NO, @"登陆返回的数据有错误!!!!");
    
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.appType forKey:kLSAccountAppTypeKey];
}

//对变量解码
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    self.appType = [coder decodeObjectForKey:kLSAccountAppTypeKey];
    return self;
}

@end

