//
//  LSLoginBaseInfo.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSLoginTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 登陆信息基类
 */
@interface LSLoginBaseInfo : NSObject

/* 账号类型 */
@property (nonatomic, assign, readonly) LSAccountType type;

/* 应用类型 */
@property (nonatomic, assign) LSAppType appType;

@end


/**
 乐心登陆信息
 */
@interface LSLifesenseLoginInfo : LSLoginBaseInfo

//@property (nonatomic, copy) NSString *clientId;     /* 客户端ID(这里不需要赋值了，我这边帮你赋值了) */

/* 登陆账号 */
@property (nonatomic, copy) NSString *loginName;

/* 密码，MD5(明文密码) */
@property (nonatomic, copy) NSString *password;



@end


/**
 医生登录信息
 */
@interface LSDoctorLoginInfo : LSLifesenseLoginInfo

/* 角色类型 */
@property (nonatomic, assign) LSDoctorAppRoleType roleType;

@end

/**
 第三方code登陆（该为基类，得使用子类登陆）
 */
@interface LSThirdPartLoginInfo : LSLoginBaseInfo

 /* 在第三方开放平台申请的appId */
@property (nonatomic, copy) NSString *appId;

/* 第三方应用登录授权码 */
@property (nonatomic, copy) NSString *code;

@end


/**
 根据openId来登录
 */
@interface LSOpenIdLoginInfo : LSLoginBaseInfo


/** openId */
@property (nonatomic, copy) NSString *openId;


/** openAccessToken */
@property (nonatomic, copy) NSString *openAccessToken;

/** 过期时间（毫秒） */
@property (nonatomic, copy) NSNumber *expireTime;

@end


/**
 微信登陆
 */
@interface LSWeixinLoginInfo : LSThirdPartLoginInfo

@end


/**
 qq登陆
 */
@interface LSQQLoginInfo : LSOpenIdLoginInfo

@end


/**
 facebook登陆
 */
@interface LSFacebookLoginInfo : LSThirdPartLoginInfo

@end


/**
 google登陆
 */
@interface LSGoogleLoginInfo : LSThirdPartLoginInfo

@end

NS_ASSUME_NONNULL_END


