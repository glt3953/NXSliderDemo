//
//  UIButton + EnlargeTouchArea.h
//  HuoBan
//
//  Created by huoban on 15-3-4.
//  Copyright (c) 2015年 Huoban inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end