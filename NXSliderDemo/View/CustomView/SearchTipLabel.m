//
//  SearchTipLabel.m
//  room107
//
//  Created by ningxia on 15/7/4.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "SearchTipLabel.h"

@implementation SearchTipLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor room107GrayColorC]];
        [self setTextAlignment:NSTextAlignmentLeft];
        [self setFont:[UIFont room107SystemFontThree]];
        [self setNumberOfLines:0];
    }
    
    return self;
}

@end
