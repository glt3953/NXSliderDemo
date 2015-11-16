//
//  NXTextSwitch.m
//  room107
//
//  Created by ningxia on 15/7/28.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXTextSwitch.h"
#import "SearchTipLabel.h"
#import "NXSwitch.h"

@interface NXTextSwitch ()

@property (nonatomic, strong) SearchTipLabel *titleLabel;
@property (nonatomic, strong) SearchTipLabel *contentLabel;
@property (nonatomic, strong) NXSwitch *onOffSwitch;
@property (nonatomic, strong) void (^switchActionHandlerBlock)(BOOL isOn);

@end

@implementation NXTextSwitch

- (id)initWithFrame:(CGRect)frame withSwitch:(BOOL)hasSwitch {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat labelWidth = CGRectGetWidth(self.bounds) / 2;
        _titleLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){0, 0, labelWidth, CGRectGetHeight(self.bounds)}];
        [_titleLabel setFont:[UIFont room107FontThree]];
        [self addSubview:_titleLabel];
        
        if (hasSwitch) {
            //原生UISwitch的宽和高固定为51、31
            _onOffSwitch = [[NXSwitch alloc] initWithFrame:(CGRect){CGRectGetWidth(self.bounds) - 51, -0.5, 51, 31}];
            [_onOffSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:_onOffSwitch];
        }
        
        CGFloat contentWidth = 150;
        CGRect frame = (CGRect){CGRectGetWidth(self.bounds) - contentWidth - 2 * 22, 0, contentWidth, CGRectGetHeight(self.bounds)};
        if (hasSwitch) {
            frame.origin.x -= 15;
        }
        _contentLabel = [[SearchTipLabel alloc] initWithFrame:frame];
        [_contentLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_contentLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
}

- (void)setContent:(NSString *)content {
    [_contentLabel setText:content];
}

- (BOOL)isOn {
    return [_onOffSwitch isOn];
}

- (void)setOn:(BOOL)isOn {
    [_onOffSwitch setOn:isOn];
    [_titleLabel setTextColor:isOn ? [UIColor room107GreenColor] : [UIColor room107GrayColorC]];
    [_contentLabel setTextColor:isOn ? [UIColor room107GreenColor] : [UIColor room107GrayColorC]];
}

- (IBAction)switchAction:(id)sender {
    UISwitch *onOffSwitch = (UISwitch *)sender;
    [_titleLabel setTextColor:[onOffSwitch isOn] ? [UIColor room107GreenColor] : [UIColor room107GrayColorC]];
    [_contentLabel setTextColor:[onOffSwitch isOn] ? [UIColor room107GreenColor] : [UIColor room107GrayColorC]];
    if (self.switchActionHandlerBlock) {
        self.switchActionHandlerBlock([onOffSwitch isOn]);
    }
}

- (void)setSwitchActionHandler:(void (^)(BOOL isOn))handler {
    self.switchActionHandlerBlock = handler;
}

- (void)setTextColor:(UIColor *)color {
    [_titleLabel setTextColor:color];
    [_contentLabel setTextColor:color];
}

- (void)setAttributedTitle:(NSMutableAttributedString *)title {
    [_titleLabel setTextColor:[UIColor room107GrayColorD]];
    [_contentLabel setTextColor:[UIColor room107GrayColorD]];
    [_titleLabel setAttributedText:title];
    
}
@end
