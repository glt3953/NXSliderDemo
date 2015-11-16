//
//  ProcedureItemView.m
//  room107
//
//  Created by ningxia on 15/7/10.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "ProcedureItemView.h"
#import "CustomLabel.h"

@interface ProcedureItemView ()

@property (nonatomic, strong) CustomLabel *orderLabel;
@property (nonatomic, strong) CustomLabel *titleLabel;

@end

@implementation ProcedureItemView

- (id)initWithFrame:(CGRect)frame andOrder:(NSUInteger)order andTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat originY = 0.0f;
        CGFloat width = 30.0f;
        _orderLabel = [[CustomLabel alloc] initWithFrame:(CGRect){CGRectGetWidth(self.bounds) / 2 - width / 2, originY, width, width}];
        [_orderLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)order]];
        [_orderLabel setTextAlignment:NSTextAlignmentCenter];
        [_orderLabel setCornerRadius:width / 2];
        [_orderLabel setBackgroundColor:[UIColor room107GrayColorC]];
        [self addSubview:_orderLabel];
        
        originY += CGRectGetHeight(_orderLabel.bounds);
        _titleLabel = [[CustomLabel alloc] initWithFrame:(CGRect){0, originY, CGRectGetWidth(self.bounds), CGRectGetHeight(_orderLabel.bounds)}];
        [_titleLabel setText:title];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor room107GrayColorC]];
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [_orderLabel setBackgroundColor:[UIColor room107GreenColor]];
        [_titleLabel setTextColor:[UIColor room107GreenColor]];
    } else {
        [_orderLabel setBackgroundColor:[UIColor room107GrayColorC]];
        [_titleLabel setTextColor:[UIColor room107GrayColorC]];
    }
}

@end
