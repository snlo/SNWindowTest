//
//  ViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "ZYSuspensionView.h"

#import "JsutDoViewController.h"


#import "NSObject+SNTopLayerWindow.h"
@interface ViewController () <ZYSuspensionViewDelegate>

@property (nonatomic, weak) ZYSuspensionView *susView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"window_test";
//    [[UIApplication sharedApplication] windows]
    
//     Just create a ZYSuspensionView
    UIColor *color = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake([ZYSuspensionView suggestXWithWidth:100], 200, 100, 100)
                                                                  color:color
                                                               delegate:self];
    susView.leanType = ZYSuspensionViewLeanTypeEachSide;
    [susView setTitle:@"JSUT" forState:UIControlStateNormal];
    [susView show];
    self.susView = susView;
    
}

- (void)creatNewWindow {
    UIWindow * currentWindow = [UIApplication sharedApplication].keyWindow;
    
    //创建一个Window
    UIWindow * testWindow = [[UIWindow alloc] initWithFrame:CGRectMake(64, 64, 64, 64)];
    testWindow.rootViewController = self;
    testWindow.windowLevel = 1000000;
    [testWindow makeKeyAndVisible];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    button.backgroundColor = [UIColor yellowColor];
    
    [testWindow addSubview:button];
    
    [currentWindow addSubview:testWindow];
    
    [currentWindow makeKeyWindow];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self creatNewWindow];
    NSLog(@"sn_md5Key - - %@",self.sn_md5Key);
    NSLog(@"%s",__func__);
}

#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
    NSLog(@"click %@, %s",suspensionView.titleLabel.text, __func__);
    
    if (self.navigationController) {
        [self.navigationController pushViewController:[[JsutDoViewController alloc] init] animated:YES];
    } else {
        [self presentViewController:[[JsutDoViewController alloc] init] animated:YES completion:^{
            
        }];
    }
}

@end
