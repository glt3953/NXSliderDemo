//
//  NXSingleValueSlider.h
//  room107
//
//  Created by ningxia on 15/8/6.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NXSingleValueSliderDelegate;

@interface NXSingleValueSlider : UIControl

@property (nonatomic, weak) id<NXSingleValueSliderDelegate> delegate;
@property (nonatomic) CGFloat maxValue;                             //default 1.0,the range is [0.0,1.0]
@property (nonatomic) CGFloat minValue;                             //default 0.0,the range is [0.0,1.0],and it must set to be less than or equal to max
@property (nonatomic) CGFloat value;                            //default 0.1,range(0.0,1.0),and it must set to be bigger than or equal to min and less than or eauql to max
@property (nonatomic, strong) UIColor *backgroundColor; // defaults to gray
@property (nonatomic, strong) UIColor *sliderColor; // defaults to white
@property (nonatomic) CGFloat cornerRadius; // defaults to 12
@property (nonatomic) CGFloat sliderOffset; // slider offset from background, top, bottom, left, right
@property (nonatomic) CGFloat shadowRadius;

- (CGFloat)sliderCenter;
- (void)setValue:(CGFloat)value;

@end

@protocol NXSingleValueSliderDelegate <NSObject>

- (void)valueDidChange:(NXSingleValueSlider *)slider;

@end
