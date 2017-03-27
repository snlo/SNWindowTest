//
//  JsutDoViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "JsutDoViewController.h"

@interface JsutDoViewController ()

@end

@implementation JsutDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
