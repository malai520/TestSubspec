//
//  LSBaseRequest+AddParam.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/13.
//  Copyright © 2017年 malai. All rights reserved.
//  地址：https://wiki.lifesense.com/doku.php?id=账号密码登录

#import <LSNetworkingModule/LSNetworkingModule.h>



@interface LSBaseRequest (AddParam)

/**
 增加url的参数

 @param param 参数值
 @param key 参数key
 */
- (void)ls_addUrlParam:(NSString *)param withKey:(NSString *)key;


/**
 增加post请求body的参数

 @param param 参数值
 @param key 参数key
 */
- (void)ls_addBodyParam:(id)param withKey:(NSString *)key;


/**
 增加共有参数（包含clientId,screenWidth,screenHeight,version,systemType,area(国际版app必填),language）
 */
- (void)ls_addPublicParam;

@end
