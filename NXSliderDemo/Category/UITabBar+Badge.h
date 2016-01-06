//
//  UITabBar+Badge.h
//  NXSliderDemo
//
//  Created by ningxia on 16/1/6.
//  Copyright © 2016年 NingXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
