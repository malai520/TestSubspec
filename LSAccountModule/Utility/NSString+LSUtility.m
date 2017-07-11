//
//  NSString+LSUtility.m
//  LSLoginSessionModule
//
//  Created by malai on 2017/1/12.
//  Copyright © 2017年 malai. All rights reserved.
//

#import "NSString+LSUtility.h"
#import <CommonCrypto/CommonDigest.h>



@implementation NSString (LSUtility)

- (NSString *)ls_md5 {
    const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}

- (NSString *)ls_encodeURL {
    NSString *newString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if (newString) {
        return newString;
    }
    return self;
}

- (NSString *)ls_decodeURL {
    
    return self.stringByRemovingPercentEncoding;
}

+ (NSString *)ls_uuid {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    NSString *UUIDString = (__bridge_transfer NSString *) CFUUIDCreateString(kCFAllocatorDefault, UUID);
    CFRelease(UUID);
    // Remove '-' in UUID
    return [[[UUIDString componentsSeparatedByString:@"-"] componentsJoinedByString:@""] lowercaseString];
}


@end
