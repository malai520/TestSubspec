//
//  LSThirdPartLoginRequest.h
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <LSNetworkingModule/LSNetworkingModule.h>
#import "LSLoginTypes.h"

@interface LSThirdPartLoginRequest : LSBaseRequest

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *clientId;

@property (nonatomic, assign) LSAccountType openAccountType;

@property (nonatomic, assign) LSAppType appType;

@end
