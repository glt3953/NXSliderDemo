//
//  RoundedGreenButton.m
//  room107
//
//  Created by ningxia on 15/7/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "RoundedGreenButton.h"

@implementation RoundedGreenButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont room107SystemFontFour]];
        [self setBackgroundColor:[UIColor room107GreenColor]];
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)setFontSize:(CGFloat)size {
    [self.titleLabel setFont:[UIFont fontWithName:fontIconName size:size]];
}

- (void)setNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setDisabledTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateDisabled];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    [self setBackgroundColor:enabled ? [UIColor room107GreenColor] : [UIColor room107GrayColorB]];
}

@end
