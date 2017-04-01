//
//  SNNavigationTopLayerWindow.m
//  SNWindowTest
//
//  Created by sunDong on 2017/4/1.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNNavigationTopLayerWindow.h"

@interface SNNavigationTopLayerWindow ()

@property (nonatomic, strong) UIView * navigationView;

@end

@implementation SNNavigationTopLayerWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isDraggabled = NO;
        
    }
    return self;
}

+ (instancetype)navigationTopLayerWindow {
    return [[SNNavigationTopLayerWindow alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
}

- (UIView *)navigationView {
    if (_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _navigationView.backgroundColor = [UIColor redColor];
    } return _navigationView;
}

@end
