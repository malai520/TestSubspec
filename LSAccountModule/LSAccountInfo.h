//
//  LSAccountInfo.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *kLSAccountUserTypeKey;     /* userType     */
FOUNDATION_EXTERN NSString *kLSAccountAccessTokenKey;  /* accessToken  */
FOUNDATION_EXTERN NSString *kLSAccountUserIdKey;       /* userId       */
FOUNDATION_EXTERN NSString *kLSAccountExpireAtKey;     /* expireAt     */
FOUNDATION_EXTERN NSString *kLSAccountLoginIdKey;      /* loginId      */
FOUNDATION_EXTERN NSString *kLSAccountAppTypeKey;      /* appType      */

@interface LSAccountInfo : NSObject

/**
 登陆凭证
 */
@property (nonatomic, readonly) NSString *accessToken;


/**
 用户id
 */
@property (nonatomic, readonly) NSString *userId;


/**
 登录凭证过期时间(时间戳)(毫秒)  !!!32位请用long long 类型
 */
@property (nonatomic, readonly) NSNumber *expireAt;


/**
 用户类型：普通用户(99),医生(0),医院管理员(1),助理(2)
 */
@property (nonatomic, readonly) NSNumber *userType;



+ (instancetype)accountInfoWithDictionary:(NSDictionary *)dic;

@end

@interface LSCookieAccountInfo : LSAccountInfo


/**
 app类型 LSAppType
 */
@property (nonatomic, copy) NSNumber *appType;




@end
