//
//  LSLoginToLifesenseRequest.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/11.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSLoginToLifesenseRequest.h"
#import "LSBaseRequest+AddParam.h"
#import "LSAccountUtility.h"

@implementation LSLoginToLifesenseRequest

- (instancetype)init {
    if (self = [super init]) {
        self.method = HTTP_POST;
        self.requestName = @"LSLoginToLifesense";
        
        [self ls_addPublicParam];
        
    }
    return self;
}

- (void)setLoginName:(NSString *)loginName {
    _loginName = loginName;
    
    [self ls_addBodyParam:loginName withKey:@"loginName"];
}

- (void)setPassword:(NSString *)password {
    _password = password;
    
    [self ls_addBodyParam:password withKey:@"password"];
}

- (void)setClientId:(NSString *)clientId {
    _clientId = clientId;
    
    [self ls_addBodyParam:clientId withKey:@"clientId"];
}

- (void)setAppType:(LSAppType)appType {
    _appType = appType;
    
    [self ls_addBodyParam:@(appType) withKey:@"appType"];
}

@end
