//
//  LSAccountUtility.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/13.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSLoginTypes.h"

@interface LSAccountUtility : NSObject


/**
 随机数

 @return 字符串
 */
+ (NSString *)udid;


/**
 当前app版本号

 @return 字符串
 */
+ (NSString *)version;


/**
 当前屏幕宽度

 @return 字符串
 */
+ (NSString *)screenWidth;


/**
 当前屏幕高度

 @return 字符串
 */
+ (NSString *)screenHeight;


/**
 当前系统

 @return 字符串
 */
+ (NSString *)systemType;


/**
 app类型

 @return 字符串
 */
+ (NSString *)appType;


/**
 设置app类型

 @param appType 每次启动的时候设置下
 */
+ (void)setAppType:(LSAppType)appType;

/**
 当前clientId（clientId 是一个与账号有关的随机数）

 @return 字符串
 */
+ (NSString *)clientId;


/**
 随机数（识别请求）

 @return 字符串
 */
+ (NSString *)requestId;


/**
 设置账号Id，主要是为了生成clientId用的，如果是乐心账号登陆则是手机号码加一个固定字符串，如果是微信登陆就是openId加一个固定字符串，如果是其他方式登陆就会有其他唯一识别码加上一个固定字符串

 @param accountId 字符串
 */
+ (void)setAccountId:(NSString *)accountId;


/**
 获取当前账号id（能够代表唯一性的，一般为账号，手机号，还有微信的openId，和qq的openId）

 @return 字符串
 */
+ (NSString *)accountId;

@end
