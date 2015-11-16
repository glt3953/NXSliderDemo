//
//  NXRangeSlider.h
//  NXRangeSlidererExample
//
//  Created by Dmitry Volevodz on 08.10.14.
//  Copyright (c) 2014 Dmitry Volevodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NXRangeSliderDelegate;

@interface NXRangeSlider : UIControl

@property (nonatomic) CGFloat maxValue;                             //default 1.0,the range is [0.0,1.0]
@property (nonatomic) CGFloat minValue;                             //default 0.0,the range is [0.0,1.0],and it must set to be less than or equal to max
@property (nonatomic) CGFloat leftValue;                            //default 0.1,range(0.0,1.0),and it must set to be bigger than or equal to min and less than or eauql to right
@property (nonatomic) CGFloat rightValue;                           //default 0.9,range(0.0,1.0),and it must set to be less than or equal to max and bigger than or eauql to left
@property (nonatomic) CGFloat minValueRange; //最小价格区间
@property (nonatomic, strong) UIColor *backgroundColor; // defaults to gray
@property (nonatomic, strong) UIColor *sliderColor; // defaults to white
@property (nonatomic) CGFloat cornerRadius; // defaults to 12
@property (nonatomic) CGFloat sliderOffset; // slider offset from background, top, bottom, left, right
@property (nonatomic) CGFloat shadowRadius;

//- (CGFloat)positionForValue:(CGFloat)value;
- (CGFloat)leftSliderCenter;
- (CGFloat)rightSliderCenter;
- (void)layoutSubviews;

@property (nonatomic, assign) id<NXRangeSliderDelegate> rangeSliderDelegate;

@end


@protocol NXRangeSliderDelegate <NSObject>

- (void)leftValueDidChange:(NXRangeSlider *)slider;
- (void)rightValueDidChange:(NXRangeSlider *)slider;

@end