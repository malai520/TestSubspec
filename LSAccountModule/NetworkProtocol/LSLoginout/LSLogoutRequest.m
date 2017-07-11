//
//  LSLogoutRequest.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/1/16.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSLogoutRequest.h"
#import "LSBaseRequest+AddParam.h"

@implementation LSLogoutRequest

- (instancetype)init {
    if (self = [super init]) {
        self.method = HTTP_POST;
        self.requestName = @"LSLogout";
        
        [self ls_addPublicParam];
        
    }
    return self;
}

@end
