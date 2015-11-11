//
//  CustomLabel.m
//  room107
//
//  Created by ningxia on 15/6/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentRight];
        [self setFont:[UIFont fontWithName:fontIconName size:CGRectGetHeight(self.bounds) / 3]];
    }
    
    return self;
}

- (void)setFontSize:(CGFloat)size {
    [self setFont:[UIFont systemFontOfSize:size]];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
