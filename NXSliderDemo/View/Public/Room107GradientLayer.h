//
//  Room107GradientLayer.h
//  room107
//
//  Created by ningxia on 15/8/13.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface Room107GradientLayer : CAGradientLayer

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andStartAlpha:(CGFloat)startAlpha andEndAlpha:(CGFloat)endAlpha;

@end
