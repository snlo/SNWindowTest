//
//  SNTopLayerWindowContainer.h
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNTopLayerWindowContainer : UIWindow

@end



@interface SNTopLayerWindowManager : NSObject

+ (instancetype)sharedManager;

/**
 获取一个窗口

 @param key 通过一个key值
 @return 结果
 */
+ (UIWindow *)windowForKey:(NSString *)key;

/**
 储存一个窗口

 @param window window
 @param key key
 */
+ (void)setWindow:(UIWindow *)window forKey:(NSString *)key;

/**
 移除一个窗口

 @param key key
 */
+ (void)removeWindowForKey:(NSString *)key;

/**
 移除所有加载的窗口
 */
+ (void)removeAllWindow;

@end
