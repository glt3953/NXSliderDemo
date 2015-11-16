//
//  NXIconTextField.m
//  room107
//
//  Created by ningxia on 15/8/19.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXIconTextField.h"
#import "IconLabel.h"

@interface NXIconTextField ()

@property (nonatomic, strong) IconLabel *iconLabel;

@end

@implementation NXIconTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat originX = 0.0f;
        CGFloat originY = 0.0f;
        _iconLabel = [[IconLabel alloc] initWithFrame:(CGRect){originX, originY, frame.size.height, frame.size.height}];
        [_iconLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_iconLabel];
        
        originX += frame.size.height;
        originY += 5.0f;
        UIView *lineView = [[UIView alloc] initWithFrame:(CGRect){originX, originY, 1, frame.size.height - 2 * originY}];
        [lineView setBackgroundColor:[UIColor room107GrayColorA]];
        [self addSubview:lineView];
        
        originX += 1 + 10;
        [self setLeftViewWidth:originX];
    }
    
    return self;
}

- (void)setIconString:(NSString *)icon {
    [_iconLabel setText:icon];
}

@end
