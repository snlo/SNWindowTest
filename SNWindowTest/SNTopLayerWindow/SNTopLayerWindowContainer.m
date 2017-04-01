//
//  SNTopLayerWindowContainer.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowContainer.h"

@implementation SNTopLayerWindowContainer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = CGFLOAT_MAX;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end

//-------------------------------------------------------

@interface SNTopLayerWindowManager ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIWindow *>* windowDictionary;

@end
@implementation SNTopLayerWindowManager

#pragma mark -- shared
static id instanse;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onesToken;
    dispatch_once(&onesToken, ^{
        instanse = [super allocWithZone:zone];
    });
    return instanse;
}
+ (instancetype)sharedManager
{
    static dispatch_once_t onestoken;
    dispatch_once(&onestoken, ^{
        instanse = [[self alloc] init];
    });
    return instanse;
}
- (id)copyWithZone:(NSZone *)zone
{
    return instanse;
};

#pragma mark --getter

- (NSMutableDictionary *)windowDictionary {
    
    if (!_windowDictionary) {
        _windowDictionary = [[NSMutableDictionary alloc] init];
    }
    return _windowDictionary;
}

#pragma mark -- public methods

+ (UIWindow *)windowForKey:(NSString *)key {
    
    return [[SNTopLayerWindowManager sharedManager].windowDictionary objectForKey:key];
}
+ (void)setWindow:(UIWindow *)window forKey:(NSString *)key {
    
    [[SNTopLayerWindowManager sharedManager].windowDictionary setObject:window forKey:key];
}
+ (void)removeWindowForKey:(NSString *)key {
    
    UIWindow * window = [[SNTopLayerWindowManager sharedManager].windowDictionary objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentingViewController) {
        [window.rootViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    window.rootViewController = nil;
    [[SNTopLayerWindowManager sharedManager].windowDictionary removeObjectForKey:key];
}
+ (void)removeAllWindow {
    
    [[SNTopLayerWindowManager sharedManager].windowDictionary.allValues enumerateObjectsUsingBlock:^(UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
        obj.rootViewController = nil;
    }];
    [[SNTopLayerWindowManager sharedManager].windowDictionary removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
