//
//  ViewController.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"


#import "JsutDoViewController.h"


#import "SNTopLayerWindowDraggableButton.h"

@interface ViewController ()


@property (nonatomic ,strong) SNTopLayerWindowDraggableButton * viewDraggableButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"window_test";
    
    
    
//    [[UIApplication sharedApplication] windows]
    self.viewDraggableButton = [SNTopLayerWindowDraggableButton draggableButtonFrame:CGRectMake(10, 700, 100, 100) clickBlock:^{
        
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    [self.viewDraggableButton show];
}
- (IBAction)handleClearAllButton:(UIButton *)sender {
    [self.viewDraggableButton dismiss];
}


@end
