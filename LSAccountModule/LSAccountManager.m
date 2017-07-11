//
//  LSAccountManager.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "LSAccountManager.h"

#import "LSLoginBaseInfo.h"

#import "LSAccountLogin.h"

#import "LSThirdPartLogin.h"

#import "LSOpenIdLogin.h"

#import "LSAccountInfo.h"

#import "LSLogoutRequest.h"
#import "LSAccountUtility.h"

#import <LSNetworkingModule/RequestMap.h>

static NSString *LSSessionCookieName = @"session";

@interface LSAccountManager ()

@property (nonatomic, strong) LSAccountLogin *accountLogin;

@property (nonatomic, strong) LSThirdPartLogin *thirdPartLogin;

@property (nonatomic, strong) LSOpenIdLogin *openIdLogin;

@property (nonatomic, strong) LSAccountInfo *accountInfo;

@property (nonatomic, strong) NSHTTPCookie *httpCookie;

@property (nonatomic, strong) LSCookieAccountInfo *cookieAccountInfo;

@property (nonatomic, strong) NSMutableArray *historyLoginInfoList;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, assign) BOOL isExpired;


@end

@implementation LSAccountManager

+ (id<LSAccountProtocol>)shareAccountManager {
    static id<LSAccountProtocol> _shareAccountManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareAccountManager = [[LSAccountManager alloc] init];
    });
    return _shareAccountManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // 获取登陆的账号信息
        _accountInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountPath]];
        
        if (_accountInfo) {
            _isLogin = YES;
        }
        
        // 获取历史账号信息
        _historyLoginInfoList = [NSMutableArray arrayWithCapacity:10];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:self.historyAccountListPath];
        [_historyLoginInfoList addObjectsFromArray:array];
        
        
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        
        
        NSString *protocolPath = nil;
        
        /* 作为一个app的时候 直接从资源里面获取 */
        if ([bundle.bundlePath hasSuffix:@".app"]) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LSAccountManager" ofType:@"bundle"];
            
            NSBundle *accountManagerBundle = [NSBundle bundleWithPath:bundlePath];
            protocolPath = [accountManagerBundle pathForResource:@"LSRequestProtocl" ofType:@"plist"];
            
        } else {
            
            // 这里加个循环，如果找不到路径，则一直往下找
            do {
                NSURL *rootBundlePath = [bundle URLForResource:@"LSAccountManager" withExtension:@"bundle"];
                
                NSBundle *accountManagerBundle = [NSBundle bundleWithURL:rootBundlePath];
                
                protocolPath = [accountManagerBundle pathForResource:@"LSRequestProtocl" ofType:@"plist"];
                
                bundle = accountManagerBundle;
            } while (protocolPath == nil);
            
        }
        
        
        
        
        // 增加网络协议到网络库
        [[RequestMap shareInstance] addProtocolWithFilePath:protocolPath];
        
        
    }
    return self;
}

- (nullable NSString *)loginWithLoginInfo:(__kindof LSLoginBaseInfo *)loginInfo successCallBack:(LSLoginCallBack)successCallBack failCallBack:(LSErrorCallBack)errorCallBack {
    
    
    __weak typeof(self) weakSelf = self;
    LSLoginCallBack tempCallBack = ^(NSInteger code, NSString *msg, LSAccountInfo *accountInfo) {
        
        weakSelf.accountInfo = accountInfo;

        
        successCallBack(code,msg,accountInfo);
    };
    
    switch (loginInfo.type) {
        case LSLoginLifesenseAccount:
        {
            LSLifesenseLoginInfo *lsLoginInfo = loginInfo;
            // 设置app唯一识别码
            [LSAccountUtility setAccountId:lsLoginInfo.loginName];
            
            return [self.accountLogin loginWithLoginInfo:loginInfo successCallBack:^(NSInteger code, NSString * _Nonnull msg, LSAccountInfo * _Nullable accountInfo) {
                // 保存登陆成功的登陆信息
                if (accountInfo) {
                    [weakSelf historyAddLoginInfo:loginInfo];
                }
                
                tempCallBack(code,msg,accountInfo);
                
            } failCallBack:errorCallBack];
            break;
        }
        case LSLoginQQAccount:
        {
            LSOpenIdLoginInfo *openIdLoginInfo = loginInfo;
            [LSAccountUtility setAccountId:openIdLoginInfo.openId];
            
            return [self.openIdLogin loginWithLoginInfo:loginInfo successCallBack:tempCallBack failCallBack:errorCallBack];
            
            break;
        }
            
        case LSLoginWexinAccount:
        case LSLoginFacebookAccount:
        case LSLoginGoogleAccount:
        {
            
            LSThirdPartLoginInfo *tpLoginInfo = loginInfo;
            // 设置app唯一识别码
            [LSAccountUtility setAccountId:tpLoginInfo.appId];
            
            return [self.thirdPartLogin loginWithLoginInfo:loginInfo successCallBack:tempCallBack failCallBack:errorCallBack];
            break;
        }
    }
}

- (nullable NSString *)logoutWithCallBack:(LSCallBack)callBack {
    id<ServerCommunicationProtocol> serverProtocol = [ServerCommunicationManager GetServerCommunication];
    
    LSLogoutRequest *requet = [[LSLogoutRequest alloc] init];
    
    return [serverProtocol sendRequest:requet completeWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        self.accountInfo = nil;
        
        // 退出登陆删除cookie
        //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:self.httpCookie];
        
        callBack(response.statusCode, response.msg);
    } failureWithResponse:^(NSURLSessionDataTask *task, LSBaseResponse *response) {
        self.accountInfo = nil;
        
        callBack(response.statusCode, response.msg);
    }];
}

- (BOOL)isExpired {
    if (self.accountInfo) {
        if (self.accountInfo.expireAt.longLongValue >= [NSDate date].timeIntervalSince1970 * 1000) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isLogined {
    return _isLogin;
}

- (nullable NSArray <LSLifesenseLoginInfo *> *)historyLoginList {
    return [self.historyLoginInfoList copy];
}

#pragma mark - Private
- (void)historyAddLoginInfo:(LSLifesenseLoginInfo *)loginInfo {
    if (loginInfo == nil) {
        return;
    }
    
    __block BOOL isContains = NO;
    
    [self.historyLoginInfoList enumerateObjectsUsingBlock:^(LSLifesenseLoginInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.loginName isEqualToString:loginInfo.loginName] && obj.appType == loginInfo.appType) {
            [self.historyLoginInfoList removeObject:obj];
            
            [self.historyLoginInfoList insertObject:loginInfo atIndex:0];
            
            isContains = YES;
            *stop = YES;
        }
    }];
    
    // 如果没有就增加，
    if (isContains == NO) {
        [self.historyLoginInfoList insertObject:loginInfo atIndex:0];
    }
    
    // 如果多余10个 就删除后面的
    if (self.historyLoginInfoList.count > 10) {
        [self.historyLoginInfoList removeObjectsInRange:NSMakeRange(10, self.historyLoginInfoList.count - 10)];
    }
    
    BOOL ret = [NSKeyedArchiver archiveRootObject:[self.historyLoginInfoList copy] toFile:[self historyAccountListPath]];
    NSAssert(ret, @"登陆信息历史列表保存失败 保存失败");
}

- (LSCookieAccountInfo *)accountInfoWithCookie:(NSHTTPCookie *)cookie {
    if (cookie == nil) {
        return nil;
    }
    
    if (![cookie.name isEqualToString:LSSessionCookieName]) {
        return nil;
    }
    
    NSString *value = cookie.value;
    
    NSString *jsonString = value.stringByRemovingPercentEncoding;
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSAssert(NO, @"%@",error);
    }
    
    return [LSCookieAccountInfo accountInfoWithDictionary:dic];
    
}

- (nullable LSCookieAccountInfo *)cookieAccountInfo {
    return [self accountInfoWithCookie:self.httpCookie];
}

#pragma mark - Setters
- (void)setAccountInfo:(LSAccountInfo *)accountInfo {
    if (accountInfo) {
        _isLogin = YES;
        
    } else {
        _isLogin = NO;
    }
    
    _accountInfo = accountInfo;
    
    BOOL ret = [NSKeyedArchiver archiveRootObject:accountInfo toFile:[self accountPath]];
    NSAssert(ret, @"登陆信息保存失败 保存失败");
}

#pragma mark - Getters
- (nullable NSHTTPCookie *)httpCookie {
    NSArray <NSHTTPCookie *> *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURL *url = [NSURL URLWithString:[RequestMap shareInstance].currentHost];
        if ([obj.domain isEqualToString:url.host]) {
            
            if ([obj.name isEqualToString:LSSessionCookieName]) {
                _httpCookie = obj;
                *stop = YES;
            }
            
        }
    }];
    return _httpCookie;
}

- (NSString *)accountPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"accountInfo"];
    return filePath;
}

- (NSString *)historyAccountListPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"historyAccountList"];
    return filePath;
}

- (LSAccountLogin *)accountLogin {
    if (_accountLogin == nil) {
        _accountLogin = [[LSAccountLogin alloc] init];
    }
    return _accountLogin;
}

- (LSThirdPartLogin *)thirdPartLogin {
    if (_thirdPartLogin == nil) {
        _thirdPartLogin = [[LSThirdPartLogin alloc] init];
    }
    return _thirdPartLogin;
}

- (LSOpenIdLogin *)openIdLogin {
    if (_openIdLogin == nil) {
        _openIdLogin = [[LSOpenIdLogin alloc] init];
    }
    return _openIdLogin;
}

@end
