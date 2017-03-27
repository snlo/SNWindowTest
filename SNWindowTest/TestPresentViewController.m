//
//  TestPresentViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "TestPresentViewController.h"

#import "ZYSuspensionView.h"

#import "JsutDoViewController.h"

@interface TestPresentViewController () <ZYSuspensionViewDelegate>

@property (nonatomic, weak) ZYSuspensionView *susView;

@end

@implementation TestPresentViewController

- (void)dealloc {
    NSLog(@"%s",__func__);
    
    [self.susView removeFromScreen];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Just create a ZYSuspensionView
    UIColor *color = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectMake([ZYSuspensionView suggestXWithWidth:100], 200, 100, 100)
                                                                  color:color
                                                               delegate:self];
    susView.leanType = ZYSuspensionViewLeanTypeEachSide;
    [susView setTitle:@"JSUT" forState:UIControlStateNormal];
    [susView show];
    self.susView = susView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
