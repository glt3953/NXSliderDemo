//
//  CircleGreenLabel.m
//  room107
//
//  Created by ningxia on 15/8/3.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CircleGreenLabel.h"

@implementation CircleGreenLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor room107GreenColor]];
        self.layer.cornerRadius = CGRectGetHeight(frame) / 2;
        self.layer.masksToBounds = YES;
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont systemFontOfSize:CGRectGetHeight(self.bounds)  * 2 / 3]];
    }
    
    return self;
}

@end
