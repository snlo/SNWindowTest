//
//  SNTopLayerWindowDraggableButton.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowDraggableButton.h"

typedef void(^ClickBlock)(void);

@interface SNTopLayerWindowDraggableButton ()

@property (nonatomic, strong) UIButton * button;

@property (nonatomic, copy) ClickBlock clickBlock;

@end

@implementation SNTopLayerWindowDraggableButton

- (instancetype)initWithFrame:(CGRect)frame clickBlock:(void(^)(void))clickBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isDraggabled = YES;
        self.leanStyle = SNTopLayerWindowViewLeanStyleEachSide;
        self.HorizontalMargin = 16;
        
        self.clickBlock = clickBlock;
        [self button];
    }
    return self;
}

+ (instancetype)draggableButtonFrame:(CGRect)frame clickBlock:(void(^)(void))clickBlock {
    return [[SNTopLayerWindowDraggableButton alloc] initWithFrame:frame clickBlock:clickBlock];
}


- (void)handleButton:(UIButton *)sneder {
    NSLog(@"touch button ");
    if (sneder.selected) {
        sneder.selected = NO;
    } else {
        sneder.selected = YES;
    }
}



#pragma mark -- getter
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _button.alpha = .7f;
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"窗口按钮" forState:UIControlStateNormal];
        [_button setTitle:@"选中" forState:UIControlStateSelected];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.layer.cornerRadius = _button.frame.size.width / 2;
        _button.layer.borderColor = [UIColor blackColor].CGColor;
        _button.layer.borderWidth = 1;
        [self addSubview:_button];
        
        [_button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        
    } return _button;
}

@end
