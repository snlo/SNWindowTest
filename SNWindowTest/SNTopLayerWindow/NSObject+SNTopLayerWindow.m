//
//  NSObject+SNTopLayerWindow.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "NSObject+SNTopLayerWindow.h"

#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@implementation NSObject (SNTopLayerWindow)

- (NSString *)sn_md5Key
{
    NSString *string = objc_getAssociatedObject(self, _cmd);
    
    if (string.length <= 0) {
        
        string = [self getCurrentMd5Key];
        
        objc_setAssociatedObject(self, @selector(sn_md5Key), string, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return string;
}

- (NSString *)getCurrentMd5Key
{
    const char *cString = [[NSString string] UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cString, (unsigned int)strlen(cString), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

@end
