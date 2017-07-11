//
//  LSAccountProtocol.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAccountLoginProtocol.h"
#import "LSLoginTypes.h"

@class LSLoginBaseInfo;
@class LSAccountInfo;
@class LSCookieAccountInfo;
@class LSLifesenseLoginInfo;

NS_ASSUME_NONNULL_BEGIN

@protocol LSAccountProtocol <LSAccountLoginProtocol>

@required

/**
 退出登陆

 @param callBack 回调
 @return task （返回nil 表示操作失败）
 */
- (nullable NSString *)logoutWithCallBack:(LSCallBack)callBack;


/**
 这个是为了兼容旧版的
 当注册成功之后，因为没有调用登陆而直接登陆了，这个时候需要将用户信息交给本模块存储，或者当token失效之后，清理数据的时候可以调用，其他时候应该不需要调用了，功能就是存储或者清理登陆信息

 @param accountInfo 用户信息
 */
- (void)setAccountInfo:(nullable LSAccountInfo *)accountInfo;


/**
 旧版用户信息

 @return 用户信息类
 */
- (nullable LSAccountInfo *)accountInfo;


/**
 新版用户信息，直接从cookie上拿的 ，websocket的逻辑如果没有新版用户信息，则用旧的用户信息，

 @return 用户信息类
 */
- (nullable LSCookieAccountInfo *)cookieAccountInfo;


/**
 登陆的cookie信息

 @return cookie
 */
- (nullable NSHTTPCookie *)httpCookie;


/**
 历史记录 （最多保留10个，如果有重复的会替换） 按时间倒序

 @return array
 */
- (nullable NSArray <LSLifesenseLoginInfo *> *)historyLoginList;


/**
 增加历史记录 （主要是注册的时候使用）

 @param loginInfo 登陆信息
 */
- (void)historyAddLoginInfo:(LSLifesenseLoginInfo *)loginInfo;


/**
 是否过期

 @return bool
 */
- (BOOL)isExpired;

/**
 是否登陆

 @return bool
 */
- (BOOL)isLogined;



@end

NS_ASSUME_NONNULL_END
