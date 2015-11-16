//
//  GreenColorTitleButton.m
//  room107
//
//  Created by ningxia on 15/8/19.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "GreenColorTitleButton.h"

@implementation GreenColorTitleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor room107GreenColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:fontIconName size:CGRectGetHeight(self.bounds) * 3 / 4]];
    }
    
    return self;
}

@end
