//
//  NSString+LSUtility.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (LSUtility)


/**
 md5加密

 @return 返回md5
 */
- (NSString *)ls_md5;


/**
 加密Url

 @return url
 */
- (NSString *)ls_encodeURL;


/**
 解密Url

 @return url
 */
- (NSString *)ls_decodeURL;


/**
 一个32位的随机数

 @return 字符串
 */
+ (NSString *)ls_uuid;


@end
