//
//  RoundedYellowLabel.m
//  room107
//
//  Created by ningxia on 15/8/1.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "RoundedYellowLabel.h"

@implementation RoundedYellowLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor room107YellowColor]];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont systemFontOfSize:CGRectGetHeight(self.bounds) / 2]];
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)setFontSize:(CGFloat)size {
    [self setFont:[UIFont systemFontOfSize:size]];
}

@end
