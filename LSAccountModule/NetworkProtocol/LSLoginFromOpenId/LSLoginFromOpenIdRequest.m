//  
//  LSLoginFromOpenIdRequest.m
//  LSWearable
//  
//  Created by malai on 2017/04/18
//  Copyright © 2017年 lifesense. All rights reserved.
//  LSOpenIdLogin

#import "LSLoginFromOpenIdRequest.h"
#import "LSBaseRequest+AddParam.h"
#import "LSAccountUtility.h"

@implementation LSLoginFromOpenIdRequest

- (instancetype)init {

	if (self = [super init]) {

		self.method = HTTP_POST;
		self.requestName = @"LSLoginFromOpenId";
        
        [self ls_addPublicParam];
        
        [self ls_addUrlParam:[LSAccountUtility appType] withKey:@"appType"];

	}
	return self;
}

- (void)setOpenId:(NSString *)openId {
    _openId = [openId copy];
    if (openId) {
        NSDictionary *dict = @{@"openId" : openId};
        [self addDictionaryValue:dict];
    }
}


- (void)setExpireTime:(NSNumber *)expireTime {

	_expireTime = [expireTime copy];
    
    [self ls_addBodyParam:expireTime withKey:@"expireTime"];
}

- (void)setOpenAccessToken:(NSString *)openAccessToken {

	_openAccessToken = [openAccessToken copy];
    
    [self ls_addBodyParam:openAccessToken withKey:@"openAccessToken"];
}

- (void)setOpenAccountType:(LSAccountType)openAccountType {
    _openAccountType = openAccountType;
    
    [self ls_addBodyParam:@(openAccountType) withKey:@"openAccountType"];
}

- (void)setAppType:(LSAppType)appType {
    _appType = appType;
    
    [self ls_addBodyParam:@(appType) withKey:@"appType"];
}


@end
