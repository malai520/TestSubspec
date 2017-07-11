//
//  LSOpenIdLogin.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/4/18.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSOpenIdLogin.h"
#import "LSLoginBaseInfo.h"
#import <LSNetworkingModule/LSNetworkingModule.h>
#import "LSLoginFromOpenIdRequest.h"
#import "LSAccountInfo.h"
#import "LSBaseLoginResponse.h"

@implementation LSOpenIdLogin

- (nullable NSString *)loginWithLoginInfo:(__kindof LSOpenIdLoginInfo *)loginInfo successCallBack:(LSLoginCallBack)successCallBack failCallBack:(LSErrorCallBack)failCallBack {
    LSLoginFromOpenIdRequest *requet = [[LSLoginFromOpenIdRequest alloc] init];
    requet.openId = loginInfo.openId;
    requet.openAccessToken = loginInfo.openAccessToken;
    requet.expireTime = loginInfo.expireTime;
    requet.openAccountType = loginInfo.type;
    requet.appType = loginInfo.appType;
    
    id<ServerCommunicationProtocol> serverProtocol = [ServerCommunicationManager GetServerCommunication];
    
    return [serverProtocol sendRequest:requet completeWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        
        NSAssert([response isKindOfClass:[LSBaseLoginResponse class]], @"response should be LSBaseLoginResponse");
        
        LSBaseLoginResponse *loginResponse = (LSBaseLoginResponse *)response;
        successCallBack(response.statusCode, response.msg, loginResponse.accountInfo);
        
    } failureWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        failCallBack(response.nsError);
    }];
    
    return nil;
}

@end
