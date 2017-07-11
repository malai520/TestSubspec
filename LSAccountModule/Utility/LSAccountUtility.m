//
//  LSAccountUtility.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/13.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSAccountUtility.h"
#import <UIKit/UIKit.h>
#import "NSString+LSUtility.h"

static NSString *const kLSWCurrentAccountIdKey = @"kLSWCurrentAccountIdKey";

static NSString *const kLSWAccountIdPreString = @"%@_ClientId";

static LSAppType _appType = LSAppLifesenseSportApp;


@implementation LSAccountUtility

+ (NSString *)udid {
    
    return [NSString ls_uuid];
}

+ (NSString *)version {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return nowVersion;
}

+ (NSString *)screenWidth {
    return [NSString stringWithFormat:@"%.0f",CGRectGetWidth([UIScreen mainScreen].bounds)];
}

+ (NSString *)screenHeight {
    return [NSString stringWithFormat:@"%.0f",CGRectGetHeight([UIScreen mainScreen].bounds)];
}

+ (NSString *)systemType {
    return [NSString stringWithFormat:@"%@",@(LSSystemiOS)];
}

+ (NSString *)appType {
    return [NSString stringWithFormat:@"%@",@(_appType)];
}

+ (void)setAppType:(LSAppType)appType {
    _appType = appType;
}

+ (NSString *)clientId {
    return [self clientIdForAccountId:[self accountId]];
}

+ (NSString *)requestId {
    return [NSString ls_uuid];
}

+ (NSString *)accountId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLSWCurrentAccountIdKey];
}

+ (void)setAccountId:(NSString *)accountId {
    [[NSUserDefaults standardUserDefaults] setObject:accountId forKey:kLSWCurrentAccountIdKey];
}

#pragma mark - Private
+ (NSString *)clientIdForAccountId:(NSString *)accountId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *LSUDID = [defaults objectForKey:[self clientIdKeyForAccountId:accountId]];
    if (!LSUDID) {
        LSUDID = [NSString ls_uuid];
        [defaults setObject:LSUDID forKey:[self clientIdKeyForAccountId:accountId]];
    }
    return LSUDID;
}

+ (NSString *)clientIdKeyForAccountId:(NSString *)acccountId {
    return [NSString stringWithFormat:kLSWAccountIdPreString, acccountId];
}


@end
