//
//  NXRangeSlider.m
//  NXRangeSlidererExample
//
//  Created by Dmitry Volevodz on 08.10.14.
//  Copyright (c) 2014 Dmitry Volevodz. All rights reserved.
//

#import "NXRangeSlider.h"

@interface NXRangeSlider ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *leftSliderView;
@property (strong, nonatomic) UIView *rightSliderView;
//@property (nonatomic) CGFloat minPos;
//@property (nonatomic) CGFloat maxPos;
@property (nonatomic) CGFloat leftSliderMinPos;
@property (nonatomic) CGFloat leftSliderMaxPos;
@property (nonatomic) CGFloat rightSliderMinPos;
@property (nonatomic) CGFloat rightSliderMaxPos;
@property (nonatomic) CGFloat valuerPerPixel; //每像素的值

@end

@implementation NXRangeSlider

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
    _leftValue = 0.0;
    _rightValue = 1.0;
    _minValueRange = 0.1;
    _cornerRadius = [self sliderWidth] / 2;
    _backgroundColor = [UIColor lightGrayColor];
    _sliderOffset = 1.0f;
    _shadowRadius = 1.0f;
    self.sliderColor = [UIColor whiteColor];
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.userInteractionEnabled = YES;
    [self addSubview:self.backgroundView];
    
    self.leftSliderView = [[UIView alloc] init];
    [self addSubview:self.leftSliderView];
    //添加阴影效果
    self.leftSliderView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.leftSliderView.layer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
    self.leftSliderView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    UIPanGestureRecognizer *leftSliderRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftSliderMoved:)];
    [self.leftSliderView addGestureRecognizer:leftSliderRec];
    
    self.rightSliderView = [[UIView alloc] init];
    [self addSubview:self.rightSliderView];
    //添加阴影效果
    self.rightSliderView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rightSliderView.layer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
    self.rightSliderView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    UIPanGestureRecognizer *rightSliderRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightSliderMoved:)];
    [self.rightSliderView addGestureRecognizer:rightSliderRec];
}

- (CGFloat)sliderWidth{
    return CGRectGetHeight(self.bounds) - 2 * self.sliderOffset;
}

- (void)layoutSubviews {
    self.backgroundView.backgroundColor = self.backgroundColor;
    self.leftSliderView.backgroundColor = self.sliderColor;
    self.rightSliderView.backgroundColor = self.sliderColor;
    self.backgroundView.frame = [self convertRect:self.frame fromView:self.superview];
    self.backgroundView.layer.cornerRadius = self.cornerRadius;
    self.leftSliderView.layer.cornerRadius = self.cornerRadius - self.sliderOffset / 2;
    self.leftSliderView.layer.shadowRadius = _shadowRadius; //阴影半径
    self.rightSliderView.layer.cornerRadius = self.cornerRadius - self.sliderOffset / 2;
    self.rightSliderView.layer.shadowRadius = _shadowRadius; //阴影半径
    
    CGFloat leftThumbCenter = [self positionForValue:_leftValue];
    self.leftSliderView.frame = CGRectMake(leftThumbCenter - [self sliderWidth] / 2, _sliderOffset, [self sliderWidth], [self sliderWidth]);
    if ([self.rangeSliderDelegate respondsToSelector:@selector(leftValueDidChange:)]) {
        [self.rangeSliderDelegate leftValueDidChange:self];
    }
    
    CGFloat rightThumbCenter = [self positionForValue:_rightValue];
    self.rightSliderView.frame = CGRectMake(rightThumbCenter - [self sliderWidth] / 2, _sliderOffset, [self sliderWidth], [self sliderWidth]);
    if ([self.rangeSliderDelegate respondsToSelector:@selector(rightValueDidChange:)]) {
        [self.rangeSliderDelegate rightValueDidChange:self];
    }
    
//    _minPos = 0 + self.sliderOffset;
//    _maxPos = self.frame.size.width - self.sliderOffset - [self sliderWidth];
    _leftSliderMinPos = self.sliderOffset;
    _leftSliderMaxPos = self.frame.size.width - 3 * self.sliderOffset - 2 * [self sliderWidth];
    _rightSliderMinPos = 3 * self.sliderOffset + [self sliderWidth];
    _rightSliderMaxPos = self.frame.size.width - (self.sliderOffset + [self sliderWidth]);
    _valuerPerPixel = (_maxValue - _minValue - _minValueRange) / (_leftSliderMaxPos - _leftSliderMinPos);
//    _valuerPerPixel = (_maxValue - _minValue - _minValueRange) / (_maxPos - _minPos);
}

- (CGFloat)positionForValue:(CGFloat)value {
    return (CGRectGetWidth(self.bounds) - [self sliderWidth]) * (value - _minValue) / (_maxValue - _minValue) + [self sliderWidth] / 2.0;
}

- (CGFloat)leftSliderCenter {
    return self.leftSliderView.center.x;
}

- (CGFloat)rightSliderCenter {
    return self.rightSliderView.center.x;
}

- (CGFloat)boundaryForValue:(CGFloat)value minValue:(CGFloat)minValue maxValue:(CGFloat)maxValue {
    return MIN(MAX(value, minValue), maxValue);
}

- (void)leftSliderMoved:(UIPanGestureRecognizer *)rec {
    if (rec.state == UIGestureRecognizerStateChanged) {
        CGPoint center = rec.view.center;
        CGPoint translation = [rec translationInView:rec.view];
        center = CGPointMake(center.x + translation.x, center.y);
        rec.view.center = center;
        [rec setTranslation:CGPointZero inView:rec.view];
        
        CGPoint rightCenter = self.rightSliderView.center;
        CGFloat maxPos = rightCenter.x - ([self sliderWidth] + self.sliderOffset) * 3 / 2;
        if (self.leftSliderView.frame.origin.x >= maxPos) {
            self.leftValue = self.rightValue - _minValueRange;
            self.leftSliderView.frame = (CGRect){maxPos, self.leftSliderView.frame.origin.y, self.leftSliderView.frame.size};
        } else {
            self.leftValue = _valuerPerPixel * (center.x - ([self sliderWidth] / 2 + self.sliderOffset));
            if (self.leftValue < _minValue) {
                self.leftValue = _minValue;
            }
        }
        
        if ([self.rangeSliderDelegate respondsToSelector:@selector(leftValueDidChange:)]) {
            [self.rangeSliderDelegate leftValueDidChange:self];
        }
        
        if (self.leftSliderView.frame.origin.x < _leftSliderMinPos) {
            self.leftSliderView.frame = CGRectMake(_leftSliderMinPos, self.leftSliderView.frame.origin.y, self.leftSliderView.frame.size.width, self.leftSliderView.frame.size.height);
        } else if (self.leftSliderView.frame.origin.x > _leftSliderMaxPos) {
            self.leftSliderView.frame = CGRectMake(_leftSliderMaxPos, self.leftSliderView.frame.origin.y, self.leftSliderView.frame.size.width, self.leftSliderView.frame.size.height);
        }
    }
}

- (void)rightSliderMoved:(UIPanGestureRecognizer *)rec {
    if (rec.state == UIGestureRecognizerStateChanged) {
        CGPoint center = rec.view.center;
        CGPoint translation = [rec translationInView:rec.view];
        center = CGPointMake(center.x + translation.x, center.y);
        rec.view.center = center;
        center.x -= [self sliderWidth];//右侧的滑块坐标优化
        [rec setTranslation:CGPointZero inView:rec.view];
        
        CGPoint leftCenter = self.leftSliderView.center;
        CGFloat minPos = leftCenter.x + [self sliderWidth] / 2 + 2 * self.sliderOffset;
        if (self.rightSliderView.frame.origin.x <= minPos) {
            self.rightValue = self.leftValue + _minValueRange;
            self.rightSliderView.frame = (CGRect){minPos, self.rightSliderView.frame.origin.y, self.rightSliderView.frame.size};
        } else {
            self.rightValue = _valuerPerPixel * (center.x - ([self sliderWidth] / 2 + self.sliderOffset));
            if (self.rightValue > _maxValue) {
                self.rightValue = _maxValue;
            }
        }
        
        if ([self.rangeSliderDelegate respondsToSelector:@selector(rightValueDidChange:)]) {
            [self.rangeSliderDelegate rightValueDidChange:self];
        }
        
        if (self.rightSliderView.frame.origin.x < _rightSliderMinPos) {
            self.rightSliderView.frame = CGRectMake(_rightSliderMinPos, self.rightSliderView.frame.origin.y, self.rightSliderView.frame.size.width, self.rightSliderView.frame.size.height);
        } else if (self.rightSliderView.frame.origin.x > _rightSliderMaxPos) {
            self.rightSliderView.frame = CGRectMake(_rightSliderMaxPos, self.rightSliderView.frame.origin.y, self.rightSliderView.frame.size.width, self.rightSliderView.frame.size.height);
        }
    }
}

@end
