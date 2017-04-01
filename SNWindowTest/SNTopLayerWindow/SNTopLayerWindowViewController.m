//
//  SNTopLayerWindowViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowViewController.h"

@interface SNTopLayerWindowViewController ()

@end

@implementation SNTopLayerWindowViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
