//
//  SelectButton.m
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitle:@"\ue643" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor room107GrayColorC] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont room107FontThree]];
    }
    
    return self;
}

- (IBAction)buttonDidClick:(id)sender {
    if ([self.titleLabel.textColor isEqual:[UIColor room107GrayColorC]]) {
        [self setTitle:@"\ue644" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor room107GreenColor] forState:UIControlStateNormal];
    } else {
        [self setTitle:@"\ue643" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor room107GrayColorC] forState:UIControlStateNormal];
    }
}

@end
