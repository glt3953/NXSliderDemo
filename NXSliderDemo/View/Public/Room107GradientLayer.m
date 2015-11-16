//
//  Room107GradientLayer.m
//  room107
//
//  Created by ningxia on 15/8/13.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107GradientLayer.h"

@implementation Room107GradientLayer

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andStartAlpha:0.0f andEndAlpha:1.0f];
}

- (id)initWithFrame:(CGRect)frame andStartAlpha:(CGFloat)startAlpha andEndAlpha:(CGFloat)endAlpha {
    self = (Room107GradientLayer *)[CAGradientLayer layer];
    
    if (self) {
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorFromHexString:@"#000000" alpha:startAlpha] CGColor],
                           (id)[[UIColor colorFromHexString:@"#000000" alpha:endAlpha] CGColor],
                           nil];
        [self setColors:colors];
        [self setFrame:frame];
    }
    
    return self;
}

@end
