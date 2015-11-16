//
//  NXSingleValueSlider.m
//  room107
//
//  Created by ningxia on 15/8/6.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXSingleValueSlider.h"

@interface NXSingleValueSlider ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic) CGFloat sliderMinPos;
@property (nonatomic) CGFloat sliderMaxPos;
@property (nonatomic) CGFloat valuerPerPixel; //每像素的值

@end

@implementation NXSingleValueSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayers];
    }
    return self;
}

- (void)initLayers {
    _maxValue = 1.0;
    _minValue = 0.0;
    _cornerRadius = [self sliderWidth] / 2;
    _backgroundColor = [UIColor lightGrayColor];
    _sliderOffset = 1.0f;
    _shadowRadius = 1.0f;
    self.sliderColor = [UIColor whiteColor];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.userInteractionEnabled = YES;
    [self addSubview:self.backgroundView];
    
    self.sliderView = [[UIView alloc] init];
    [self addSubview:self.sliderView];
    //添加阴影效果
    self.sliderView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.sliderView.layer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
    self.sliderView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    UIPanGestureRecognizer *sliderRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliderMoved:)];
    [self.sliderView addGestureRecognizer:sliderRec];
}

- (CGFloat)sliderWidth{
    return CGRectGetHeight(self.bounds) - 2 * self.sliderOffset;
}

- (void)layoutSubviews {
    self.backgroundView.backgroundColor = self.backgroundColor;
    self.sliderView.backgroundColor = self.sliderColor;
    self.backgroundView.frame = [self convertRect:self.frame fromView:self.superview];
    self.backgroundView.layer.cornerRadius = self.cornerRadius;
    self.sliderView.layer.cornerRadius = self.cornerRadius - self.sliderOffset / 2;
    self.sliderView.layer.shadowRadius = _shadowRadius; //阴影半径
    
    CGFloat thumbCenter = [self positionForValue:_value];
    self.sliderView.frame = CGRectMake(thumbCenter - [self sliderWidth] / 2, _sliderOffset, [self sliderWidth], [self sliderWidth]);
    if ([self.delegate respondsToSelector:@selector(valueDidChange:)]) {
        [self.delegate valueDidChange:self];
    }
    
    _sliderMinPos = self.sliderOffset;
    _sliderMaxPos = self.frame.size.width - 2 * self.sliderOffset - [self sliderWidth];
    _valuerPerPixel = (_maxValue - _minValue) / (_sliderMaxPos - _sliderMinPos);
}

- (CGFloat)positionForValue:(CGFloat)value {
    return (CGRectGetWidth(self.bounds) - [self sliderWidth]) * (value - _minValue) / (_maxValue - _minValue) + [self sliderWidth] / 2.0;
}

- (CGFloat)sliderCenter {
    return self.sliderView.center.x;
}

- (void)setValue:(CGFloat)value {
    _value = value;
    
    [self layoutSubviews];
}

- (CGFloat)boundaryForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue {
    return MIN(MAX(value, minValue), maxValue);
}

- (void)sliderMoved:(UIPanGestureRecognizer *)rec {
    if (rec.state == UIGestureRecognizerStateChanged) {
        CGPoint center = rec.view.center;
        CGPoint translation = [rec translationInView:rec.view];
        center = CGPointMake(center.x + translation.x, center.y);
        rec.view.center = center;
        [rec setTranslation:CGPointZero inView:rec.view];
        
        self.value = _valuerPerPixel * (center.x - ([self sliderWidth] / 2 + self.sliderOffset));
        if (self.value < _minValue) {
            self.value = _minValue;
        }
        if (self.value > _maxValue) {
            self.value = _maxValue;
        }
        
        if ([self.delegate respondsToSelector:@selector(valueDidChange:)]) {
            [self.delegate valueDidChange:self];
        }
        
        if (self.sliderView.frame.origin.x < _sliderMinPos) {
            self.sliderView.frame = CGRectMake(_sliderMinPos, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
        } else if (self.sliderView.frame.origin.x > _sliderMaxPos) {
            self.sliderView.frame = CGRectMake(_sliderMaxPos, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
        }
    }
}

@end
