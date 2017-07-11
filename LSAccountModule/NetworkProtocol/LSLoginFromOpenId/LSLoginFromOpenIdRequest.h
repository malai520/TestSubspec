//  
//  LSLoginFromOpenIdRequest.h
//  LSWearable
//  
//  Created by malai on 2017/04/18
//  Copyright © 2017年 lifesense. All rights reserved.
//  LSOpenIdLogin

#import <LSNetworkingModule/LSNetworkingModule.h>
#import "LSLoginTypes.h"

@interface LSLoginFromOpenIdRequest : LSBaseRequest

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSNumber *expireTime;

@property (nonatomic, copy) NSString *openAccessToken;

@property (nonatomic, assign) LSAccountType openAccountType;

@property (nonatomic, assign) LSAppType appType;



@end

