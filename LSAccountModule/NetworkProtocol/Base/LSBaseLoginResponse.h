//
//  LSBaseLoginResponse.h
//  LSAccountModuleExample
//
//  Created by malai on 2017/6/14.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <LSNetworkingModule/LSJSonResponse.h>

@class LSAccountInfo;

@interface LSBaseLoginResponse : LSJSonResponse

@property (nonatomic, strong) LSAccountInfo *accountInfo;

@end
