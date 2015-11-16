//
//  CircleGreenMarkView.m
//  room107
//
//  Created by ningxia on 15/7/22.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CircleGreenMarkView.h"

@implementation CircleGreenMarkView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor room107GreenColor]];
        self.layer.cornerRadius = CGRectGetHeight(frame) / 2;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

@end
