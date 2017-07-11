//
//  LSAccountLogin.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSAccountLogin.h"
#import "LSLoginBaseInfo.h"
#import "LSAccountInfo.h"
#import "LSAccountUtility.h"

#import "LSBaseLoginResponse.h"

#import <LSNetworkingModule/LSNetworkingModule.h>

#import "LSLoginToLifesenseRequest.h"
#import "LSDoctorLoginRequest.h"

@interface LSAccountLogin ()

@end

@implementation LSAccountLogin

- (nullable NSString *)loginWithLoginInfo:(__kindof LSLifesenseLoginInfo *)loginInfo successCallBack:(LSLoginCallBack)successCallBack failCallBack:(LSErrorCallBack)errorCallBack {
    
   id<ServerCommunicationProtocol> serverProtocol = [ServerCommunicationManager GetServerCommunication];
    
    LSLoginToLifesenseRequest *requet = nil;
    
    if ([loginInfo isKindOfClass:[LSDoctorLoginInfo class]]) {
        LSDoctorLoginInfo *doctorInfo = loginInfo;
        LSDoctorLoginRequest *doctorRequest = [[LSDoctorLoginRequest alloc] init];
        doctorRequest.roleType = doctorInfo.roleType;
        requet = doctorRequest;
    } else {
        requet = [[LSLoginToLifesenseRequest alloc] init];
    }
    
    requet.loginName = loginInfo.loginName;
    requet.password = loginInfo.password;
    requet.clientId = [LSAccountUtility clientId];
    requet.appType = loginInfo.appType;
    
    return [serverProtocol sendRequest:requet completeWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        
        NSAssert([response isKindOfClass:[LSBaseLoginResponse class]], @"response should be LSBaseLoginResponse");
        
        LSBaseLoginResponse *loginResponse = (LSBaseLoginResponse *)response;
        successCallBack(response.statusCode, response.msg, loginResponse.accountInfo);
        
    } failureWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        errorCallBack(response.nsError);
    }];
    
//    return [serverProtocol sendRequest:requet complete:^(NSInteger code, NSString *message, id responseData) {
////        NSLog(@"%zd%@%@", code, message, responseData);
//    LSAccountInfo *accountInfo = nil;
//        if (code == 200) {
//            accountInfo = [LSAccountInfo accountInfoWithDictionary:responseData];
//        }
//        successCallBack(response, message, accountInfo);
//
//    } failure:errorCallBack];
}

@end
