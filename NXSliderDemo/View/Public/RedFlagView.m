//
//  RedFlagView.m
//  room107
//
//  Created by ningxia on 15/10/26.
//  Copyright © 2015年 107room. All rights reserved.
//

#import "RedFlagView.h"

@implementation RedFlagView

- (id)initWithOrigin:(CGPoint)origin {
    CGFloat viewWidth = 8;
    self = [super initWithFrame:(CGRect){origin, viewWidth, viewWidth}];
    
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];
        self.layer.cornerRadius = viewWidth / 2;
//        self.layer.masksToBounds = YES;
    }
    
    return self;
}

@end
