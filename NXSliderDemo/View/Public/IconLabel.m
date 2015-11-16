//
//  IconLabel.m
//  room107
//
//  Created by ningxia on 15/8/19.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "IconLabel.h"

@implementation IconLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor room107GrayColorD]];
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setFont:[UIFont room107FontFour]];
    }
    
    return self;
}

@end
