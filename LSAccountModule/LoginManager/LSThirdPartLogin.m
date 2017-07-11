//
//  LSThirdPartLogin.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSThirdPartLogin.h"

#import "LSAccountInfo.h"
#import "LSLoginBaseInfo.h"
#import "LSAccountUtility.h"
#import "LSBaseLoginResponse.h"

#import "LSThirdPartLoginRequest.h"

#import <LSNetworkingModule/LSNetworkingModule.h>

@implementation LSThirdPartLogin

- (nullable NSString *)loginWithLoginInfo:(__kindof LSThirdPartLoginInfo *)loginInfo successCallBack:(LSLoginCallBack)successCallBack failCallBack:(LSErrorCallBack)failCallBack {
    
    id<ServerCommunicationProtocol> serverProtocol = [ServerCommunicationManager GetServerCommunication];
    
    LSThirdPartLoginRequest *requet = [[LSThirdPartLoginRequest alloc] init];
    requet.appId = loginInfo.appId;
    requet.code = loginInfo.code;
    requet.clientId = [LSAccountUtility clientId];
    requet.openAccountType = loginInfo.type;
    requet.appType = loginInfo.appType;
    
    return [serverProtocol sendRequest:requet completeWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        
        NSAssert([response isKindOfClass:[LSBaseLoginResponse class]], @"response should be LSBaseLoginResponse");
        
        LSBaseLoginResponse *loginResponse = (LSBaseLoginResponse *)response;
        successCallBack(response.statusCode, response.msg, loginResponse.accountInfo);
        
    } failureWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        failCallBack(response.nsError);
    }];
}

@end
