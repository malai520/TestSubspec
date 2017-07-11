//
//  LSLoginToLifesenseRequest.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/11.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <LSNetworkingModule/LSNetworkingModule.h>
#import "LSLoginTypes.h"

@interface LSLoginToLifesenseRequest : LSBaseRequest

/**
 客户端ID
 */
@property (nonatomic, copy) NSString *clientId;

/**
 登录账号（目前仅支持手机号码）
 */
@property (nonatomic, copy) NSString *loginName;


/**
 密码，MD5(明文密码)
 */
@property (nonatomic, copy) NSString *password;


/**
 应用类型(健康公众号:1,乐心健康APP:2,乐心健康医生PC端:3,乐心健康医生APP端4,乐心运动公众号:5,乐心运动APP:6)
 */
@property (nonatomic, assign) LSAppType appType;

@end
