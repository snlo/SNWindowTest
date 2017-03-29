//
//  SNTopLayerWindowDraggableButton.h
//  SNWindowTest
//
//  Created by sunDong on 2017/3/28.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "SNTopLayerWindowView.h"

@interface SNTopLayerWindowDraggableButton : SNTopLayerWindowView

+ (instancetype)draggableButtonFrame:(CGRect)frame clickBlock:(void(^)(void))clickBlock;

@end
