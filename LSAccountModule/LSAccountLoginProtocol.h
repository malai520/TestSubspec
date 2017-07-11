//
//  LSAccountLoginProtocol.h
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSLoginTypes.h"

@class LSLoginBaseInfo;

NS_ASSUME_NONNULL_BEGIN

@protocol LSAccountLoginProtocol <NSObject>

/**
 登陆账号
 
 @param loginInfo 登陆的信息
 @param successCallBack 成功回调
 @param failCallBack 失败回调
 */
- (nullable NSString *)loginWithLoginInfo:(__kindof LSLoginBaseInfo *)loginInfo successCallBack:(LSLoginCallBack)successCallBack failCallBack:(LSErrorCallBack)failCallBack;

NS_ASSUME_NONNULL_END

@end
