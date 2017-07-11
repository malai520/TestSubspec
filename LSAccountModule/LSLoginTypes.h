//
//  LSLoginTypes.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSAccountInfo;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LSAppType) {
    LSAppHealthPublicNumberApp = 1,         /* 健康公众号 */
    LSAppLifesenseHealthApp = 2,            /* 乐心健康app */
    LSAPPLifesenseHealthDoctorPc = 3,       /* 乐心健康医生PC端 */
    LSAPPLifesenseHealthDcotorApp = 4,      /* 乐心健康医生App端 */
    LSAPPLifesenseSportPublicNumberApp = 5, /* 乐心运动公众号 */
    LSAppLifesenseSportApp = 6,             /* 乐心运动app */
    
    LSAppLifesenseSportInternationalApp = 12, /* 乐心运动国际版app */
    
};

typedef NS_ENUM(NSUInteger, LSAccountType) {
    LSLoginLifesenseAccount = 0,  /* 乐心登陆 */
    LSLoginWexinAccount = 1,      /* 微信登陆 */
    LSLoginQQAccount = 2,         /* qq登陆 */
    LSLoginGoogleAccount = 3,     /* google登陆 */
    LSLoginFacebookAccount = 4,   /* facebook登陆 */
};


typedef NS_ENUM(NSUInteger, LSSystemType) {
    LSSystemiOS = 1,        /* iOS系统 */
    LSSystemAndroid = 2,    /* Android系统 */
    
};


typedef NS_ENUM(NSUInteger, LSDoctorAppRoleType) {
    LSDoctorAppRoleDoctor = 0,          /* 医生 */
    LSDoctorAppRoleHospitalManager = 1, /* 医院管理员 */
    LSDoctorAppRoleAssistant = 2,       /* 助理 */
};

typedef void(^LSLoginCallBack)(NSInteger code, NSString *msg, LSAccountInfo *__nullable accountInfo);
typedef void(^LSCallBack)(NSInteger code, NSString *msg);
typedef void(^LSErrorCallBack)(NSError *error);



NS_ASSUME_NONNULL_END


