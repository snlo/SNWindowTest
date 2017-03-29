//
//  SNTopLayerWindowView.h
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+SNTopLayerWindow.h"

#import "SNTopLayerWindowContainer.h"
#import "SNTopLayerWindowViewController.h"


typedef NS_ENUM(NSUInteger, SNTopLayerWindowViewLeanStyle) {
    /*无状态，也就是在屏幕范围内随意停靠*/
    SNTopLayerWindowViewLeanStyleNormal,
    /*只能屏幕左右两侧依靠*/
    SNTopLayerWindowViewLeanStyleHorizontal,
    /*只能在屏幕上下左右边侧依靠*/
    SNTopLayerWindowViewLeanStyleEachSide,
    
};

@interface SNTopLayerWindowView : UIView

/**
 窗口依靠的，默认为‘SNTopLayerWindowViewLeanStyleNormal’
 */
@property (nonatomic, assign) SNTopLayerWindowViewLeanStyle leanStyle;

/**
 是否可拖拽，默认为NO
 */
@property (nonatomic, assign) BOOL isDraggabled;

/**
 展示这个窗口视图
 */
- (void)show;

/**
 让这个窗口视图离开，
 */
- (void)dismiss;

@end
