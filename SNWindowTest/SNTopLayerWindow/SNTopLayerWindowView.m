//
//  SNTopLayerWindowView.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowView.h"

@interface SNTopLayerWindowView ()

@property (nonatomic, assign) CGPoint initialCenter;
@property (nonatomic, assign) CGPoint tempOrigin;

@end

@implementation SNTopLayerWindowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tempOrigin = self.frame.origin;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - event response
- (void)handlePanGesture:(UIPanGestureRecognizer*)sender
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panMvovePoint = [sender translationInView:appWindow];
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        [self checkCurrentWindowInitialCenter];
    }else if(sender.state == UIGestureRecognizerStateChanged) {
        [SNTopLayerWindowManager windowForKey:self.sn_md5Key].center =
        CGPointMake(
                    self.initialCenter.x + panMvovePoint.x,
                    self.initialCenter.y + panMvovePoint.y);
    }else if(sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        
        CGPoint panPoint = [sender locationInView:appWindow];
        
        CGFloat topLayerWindowWidth = self.frame.size.width;
        CGFloat topLayerWindowHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat top = fabs(panPoint.y);
        CGFloat left = fabs(panPoint.x);
        CGFloat bottom = fabs(screenHeight - top);
        CGFloat right = fabs(screenWidth - left);
        

        CGFloat minSpace = 0;

        switch (self.leanStyle) {
            case SNTopLayerWindowViewLeanStyleNormal: {
                
            } break;
            case SNTopLayerWindowViewLeanStyleHorizontal: {
                minSpace = MIN(left, right);
            } break;
            case SNTopLayerWindowViewLeanStyleEachSide: {
                minSpace = MIN(MIN(MIN(top, left), bottom), right);
            } break;
            default: {
                
            } break;
        }
        
        CGPoint newCenter = CGPointZero;
        CGFloat targetY = 0;
        
        //Correcting Y
        if (panPoint.y < topLayerWindowHeight / 2.0) {
            targetY = topLayerWindowHeight / 2.0;
        } else if (panPoint.y > (screenHeight - topLayerWindowHeight / 2.0)) {
            targetY = screenHeight - topLayerWindowHeight / 2.0;
        } else{
            targetY = self.initialCenter.y + panMvovePoint.y;
        }
        
        //Correcting X
        CGFloat targetX = 0;
        if (panPoint.x < topLayerWindowWidth / 2.0) {
            targetX = topLayerWindowWidth / 2.0;
        } else if (panPoint.x > (screenWidth - topLayerWindowWidth / 2.0)) {
            targetX = screenWidth - topLayerWindowWidth / 2.0;
        } else {
            targetX = self.initialCenter.x +panMvovePoint.x;
        }
        
        CGFloat centerXSpace = (0.5 +(self.HorizontalMargin / topLayerWindowWidth)) * topLayerWindowWidth - 0.001;
        CGFloat centerYSpace = (0.5 +(self.verticalMargin / topLayerWindowWidth) ) * topLayerWindowHeight - 0.001;
        
        if (minSpace == left) {
            //左
            newCenter = CGPointMake(centerXSpace, targetY);
        } else if (minSpace == right) {
            //右
            newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
        } else if (minSpace == top) {
            //上
            newCenter = CGPointMake(panPoint.x, centerYSpace);
        } else if (minSpace == bottom){
            //下
            newCenter = CGPointMake(panPoint.x, screenHeight - centerYSpace);
        } else {
            newCenter = CGPointMake(targetX, targetY);
        }
        
        [UIView animateWithDuration:.25 animations:^{
            [SNTopLayerWindowManager windowForKey:self.sn_md5Key].center = newCenter;
        }];
    }else{
        NSLog(@"pan state : %zd", sender.state);
    }
}

- (void)checkCurrentWindowInitialCenter {
    self.initialCenter = [SNTopLayerWindowManager windowForKey:self.sn_md5Key].center;
}

#pragma mark -- setter
- (void)setIsDraggabled:(BOOL)isDraggabled
{
    _isDraggabled = isDraggabled;
    if (isDraggabled) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        pan.delaysTouchesBegan = YES;
        
        [self addGestureRecognizer:pan];
    }
}

#pragma mark -- public method

- (void)show
{
    if ([SNTopLayerWindowManager windowForKey:self.sn_md5Key]) {
        return;
    }
    
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    UIWindow * currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    SNTopLayerWindowContainer * topLayerWindow = [[SNTopLayerWindowContainer alloc] initWithFrame:CGRectMake(self.tempOrigin.x, self.tempOrigin.y, selfWidth, selfHeight)];
    
    SNTopLayerWindowViewController * topLayerWindowViewController = [[SNTopLayerWindowViewController alloc] init];
    topLayerWindow.rootViewController = topLayerWindowViewController;
    [topLayerWindow makeKeyAndVisible];
    
    [SNTopLayerWindowManager setWindow:topLayerWindow forKey:self.sn_md5Key];
    
    self.frame = CGRectMake(0, 0, selfWidth, selfHeight);
    [topLayerWindowViewController.view addSubview:self];
    
    [currentKeyWindow makeKeyWindow];
    
    if (self.isDraggabled) {
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

        switch (self.leanStyle) {
            case SNTopLayerWindowViewLeanStyleNormal:{
            } break;
            case SNTopLayerWindowViewLeanStyleHorizontal: {
                topLayerWindow.center =
                CGPointMake(self.tempOrigin.x + selfWidth/2 > screenWidth/2 ? screenWidth - self.HorizontalMargin - selfWidth/2 : self.HorizontalMargin + selfWidth/2,
                            self.tempOrigin.y < 0 ? selfHeight/2 : self.tempOrigin.y > screenHeight ? screenHeight - selfHeight/2 : self.tempOrigin.y + selfHeight/2);
            }
                break;
            case SNTopLayerWindowViewLeanStyleEachSide: {
                topLayerWindow.center =
                CGPointMake(self.tempOrigin.x + selfWidth/2 > screenWidth/2 ? screenWidth - self.HorizontalMargin - selfWidth/2 : self.HorizontalMargin + selfWidth/2,
                            self.tempOrigin.y < self.verticalMargin ? self.verticalMargin + selfHeight/2 : self.tempOrigin.y > screenHeight - self.verticalMargin ? screenHeight - selfHeight/2 - self.verticalMargin : self.tempOrigin.y + selfHeight/2);
            } break;
            default:{
            } break;
        }
    }
}

- (void)dismiss
{
    [SNTopLayerWindowManager removeWindowForKey:self.sn_md5Key];
}
+ (void)dismissAll
{
    [SNTopLayerWindowManager removeAllWindow];
}
@end
