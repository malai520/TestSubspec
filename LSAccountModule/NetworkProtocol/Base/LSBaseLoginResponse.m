//
//  LSBaseLoginResponse.m
//  LSAccountModuleExample
//
//  Created by malai on 2017/6/14.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSBaseLoginResponse.h"
#import "LSAccountInfo.h"

@implementation LSBaseLoginResponse

- (void)parse {
    [super parse];
    
    if (self.datadict) {
        self.accountInfo = [LSAccountInfo accountInfoWithDictionary:self.datadict];
    }
    
}

- (BOOL)checkParsingVadility {
    
    if (self.accountInfo.userId && self.accountInfo.accessToken) {
        return YES;
    }
    return NO;
}

@end
