//
//  GreenTextButton.m
//  room107
//
//  Created by ningxia on 15/8/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "GreenTextButton.h"

@implementation GreenTextButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor room107GreenColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont room107SystemFontThree]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

@end
