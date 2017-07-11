//
//  LSLoginBaseInfo.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSLoginBaseInfo.h"

@implementation LSLoginBaseInfo

//对变量解码
- (id)initWithCoder:(NSCoder *)coder {
    if (coder == nil) {
        return nil;
    }
    
    
    return self;
}

//对变量编码
- (void)encodeWithCoder:(NSCoder *)coder {
    
}

@end


@implementation LSLifesenseLoginInfo

- (LSAccountType)type {
    return LSLoginLifesenseAccount;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[LSLifesenseLoginInfo class]]) {
        LSLifesenseLoginInfo *loginInfo = object;
        if ([loginInfo.loginName isEqualToString:self.loginName]
            && (loginInfo.appType == self.appType)) {
            return YES;
        }
    }
    return NO;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.loginName forKey:@"loginName"];
    [coder encodeObject:self.password forKey:@"password"];
}

//对变量解码
- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    self.loginName = [coder decodeObjectForKey:@"loginName"];
    self.password = [coder decodeObjectForKey:@"password"];
    
    return self;
}

@end

@implementation LSDoctorLoginInfo

@end

@implementation LSThirdPartLoginInfo

@end

@implementation LSOpenIdLoginInfo

@end

@implementation LSWeixinLoginInfo

- (LSAccountType)type {
    return LSLoginWexinAccount;
}

@end

@implementation LSQQLoginInfo

- (LSAccountType)type {
    return LSLoginQQAccount;
}

@end

@implementation LSFacebookLoginInfo

- (LSAccountType)type {
    return LSLoginFacebookAccount;
}

@end

@implementation LSGoogleLoginInfo

- (LSAccountType)type {
    return LSLoginGoogleAccount;
}

@end
