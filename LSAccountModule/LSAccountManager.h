//
//  LSAccountManager.h
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAccountProtocol.h"

@interface LSAccountManager : NSObject <LSAccountProtocol>

#if FOUNDATION_SWIFT_SDK_EPOCH_AT_LEAST(8)
@property (class, readonly, strong) id<LSAccountProtocol> shareAccountManager;
#endif


@end
