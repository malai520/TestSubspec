//
//  LSThirdPartLoginRequest.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSThirdPartLoginRequest.h"
#import "LSBaseRequest+AddParam.h"
#import "LSAccountUtility.h"

@implementation LSThirdPartLoginRequest

- (instancetype)init {
    if (self = [super init]) {
        self.method = HTTP_POST;
        self.requestName = @"LSThirdPartLogin";
        
        [self ls_addPublicParam];
        
        [self ls_addUrlParam:[LSAccountUtility appType] withKey:@"appType"];
        
    }
    return self;
}

- (void)setAppId:(NSString *)appId {
    _appId = appId;
    
    [self ls_addBodyParam:appId withKey:@"appId"];
}

- (void)setCode:(NSString *)code {
    _code = code;
    
    [self ls_addBodyParam:code withKey:@"code"];
}

- (void)setClientId:(NSString *)clientId {
    _clientId = clientId;
    
    [self ls_addBodyParam:clientId withKey:@"clientId"];
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
