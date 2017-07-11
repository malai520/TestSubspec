//
//  LSDoctorLoginRequest.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSDoctorLoginRequest.h"
#import "LSBaseRequest+AddParam.h"

@implementation LSDoctorLoginRequest

- (void)setRoleType:(LSDoctorAppRoleType)roleType {
    _roleType = roleType;
    
    [self ls_addBodyParam:@(roleType) withKey:@"roleType"];
}

@end
