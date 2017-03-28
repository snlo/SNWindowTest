//
//  NSObject+SNTopLayerWindow.h
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SNTopLayerWindow)
/*
    懒加载 MD5 值
 */
@property (nonatomic, readonly, copy) NSString * sn_md5Key;

@end
