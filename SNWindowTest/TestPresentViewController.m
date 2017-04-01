//
//  TestPresentViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "TestPresentViewController.h"

#import "JsutDoViewController.h"

@interface TestPresentViewController ()

@end

@implementation TestPresentViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
