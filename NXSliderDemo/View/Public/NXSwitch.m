//
//  NXSwitch.m
//  room107
//
//  Created by ningxia on 15/8/19.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXSwitch.h"

@implementation NXSwitch

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setOn:NO];
        [self setOnTintColor:[UIColor room107GreenColor]];
        [self setTintColor:[UIColor room107GrayColorB]];
    }
    
    return self;
}

@end
