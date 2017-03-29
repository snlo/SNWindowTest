//
//  SNTopLayerWindowView.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowView.h"

#define kLeanProportion (8/55.0)
#define kVerticalMargin 15.0

@interface SNTopLayerWindowView ()

@property (nonatomic, assign) CGPoint initialCenter;

@end

@implementation SNTopLayerWindowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - event response
- (void)handlePanGesture:(UIPanGestureRecognizer*)sender
{
    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
    CGPoint panPoint = [sender translationInView:appWindow];
    
    if(sender.state == UIGestureRecognizerStateBegan) {
//        self.alpha = 1;
        [self checkCurrentWindowInitialCenter];
    }else if(sender.state == UIGestureRecognizerStateChanged) {
        
        [SNTopLayerWindowManager windowForKey:self.sn_md5Key].center =
        CGPointMake(
                    self.initialCenter.x + panPoint.x,
                    self.initialCenter.y + panPoint.y);
    }else if(sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
//        self.alpha = .7;
        return;
        
        CGFloat ballWidth = self.frame.size.width;
        CGFloat ballHeight = self.frame.size.height;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(screenWidth - left);
        CGFloat top = fabs(panPoint.y);
        CGFloat bottom = fabs(screenHeight - top);
        
        CGFloat minSpace = 0;
        //        if (self.leanType == ZYSuspensionViewLeanTypeHorizontal) {
        //            minSpace = MIN(left, right);
        //        }else{
        //            minSpace = MIN(MIN(MIN(top, left), bottom), right);
        //        }
        minSpace = MIN(MIN(MIN(top, left), bottom), right);
        CGPoint newCenter = CGPointZero;
        CGFloat targetY = 0;
        
        //Correcting Y
        if (panPoint.y < kVerticalMargin + ballHeight / 2.0) {
            targetY = kVerticalMargin + ballHeight / 2.0;
        }else if (panPoint.y > (screenHeight - ballHeight / 2.0 - kVerticalMargin)) {
            targetY = screenHeight - ballHeight / 2.0 - kVerticalMargin;
        }else{
            targetY = panPoint.y;
        }
        
        CGFloat centerXSpace = (0.5 - kLeanProportion) * ballWidth;
        CGFloat centerYSpace = (0.5 - kLeanProportion) * ballHeight;
        
        if (minSpace == left) {
            newCenter = CGPointMake(centerXSpace, targetY);
        }else if (minSpace == right) {
            newCenter = CGPointMake(screenWidth - centerXSpace, targetY);
        }else if (minSpace == top) {
            newCenter = CGPointMake(panPoint.x, centerYSpace);
        }else {
            newCenter = CGPointMake(panPoint.x, screenHeight - centerYSpace);
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
    UIWindow * currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    SNTopLayerWindowContainer * topLayerWindow = [[SNTopLayerWindowContainer alloc] initWithFrame:self.frame];
    topLayerWindow.rootViewController = [[SNTopLayerWindowViewController alloc] init];
    [topLayerWindow makeKeyAndVisible];
    
    [SNTopLayerWindowManager setWindow:topLayerWindow forKey:self.sn_md5Key];
    
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [topLayerWindow addSubview:self];
    
    [currentKeyWindow makeKeyWindow];
}

- (void)dismiss
{
    [SNTopLayerWindowManager removeAllWindow];
}

@end
