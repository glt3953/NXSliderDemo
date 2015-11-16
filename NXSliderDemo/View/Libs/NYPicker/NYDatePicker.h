//
//  NYDatePicker.h
//  DatePickerDemo
//
//  Created by Naitong Yu on 15/8/4.
//  Copyright (c) 2015年 107间. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYDatePicker : UIView

@property (nonatomic) NSDate *date;

@property (nonatomic) UIFont *font; //当前选中的年月日的字体
@property (nonatomic) UIColor *color;

- (void)setDateDidChangeHandler:(void(^)(NSDate *date))handler;

@end
