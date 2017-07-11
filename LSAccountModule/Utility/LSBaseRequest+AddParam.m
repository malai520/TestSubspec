//
//  LSBaseRequest+AddParam.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/13.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSBaseRequest+AddParam.h"
#import "NSString+LSUtility.h"
#import "LSLoginTypes.h"
#import "LSAccountUtility.h"

@implementation LSBaseRequest (AddParam)

- (void)ls_addUrlParam:(NSString *)param withKey:(NSString *)key {
    
    if (param) {
        if (![self.urlAppendingString containsString:@"?"]) {
            self.urlAppendingString = @"?";
        } else {
            self.urlAppendingString = [self.urlAppendingString stringByAppendingString:@"&"];
        }
        
        self.urlAppendingString = [self.urlAppendingString stringByAppendingFormat:@"%@=%@",key.ls_encodeURL,param.ls_encodeURL];
    }
    
}

- (void)ls_addBodyParam:(id)param withKey:(NSString *)key {
    if (param) {
        NSDictionary *dic = @{key:param};
        [self addDictionaryValue:dic];
    }
}

- (void)ls_addPublicParam {
    
    [self ls_addUrlParam:[LSAccountUtility clientId] withKey:@"clientId"];
    [self ls_addUrlParam:[LSAccountUtility requestId] withKey:@"requestId"];
    [self ls_addUrlParam:[LSAccountUtility screenWidth] withKey:@"screenWidth"];
    [self ls_addUrlParam:[LSAccountUtility screenHeight] withKey:@"screenHeight"];
    [self ls_addUrlParam:[LSAccountUtility version] withKey:@"version"];
    [self ls_addUrlParam:[LSAccountUtility systemType] withKey:@"systemType"];
}

@end
