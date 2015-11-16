//
//  NYDateComponent.h
//  DatePickerDemo
//
//  Created by Naitong Yu on 15/8/5.
//  Copyright (c) 2015年 107间. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYPickerComponent : UIView

@property (nonatomic) NSArray *strings;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIFont *font;

@property (nonatomic) NSInteger selectedIndex;

+ (instancetype)pickerComponentWithFrame:(CGRect)frame andStringsArray:(NSArray *)strings;

- (instancetype)initWithFrame:(CGRect)frame andStringsArray:(NSArray *)strings;

- (void)setIndexDidChangeHandler:(void(^)(NSInteger index))handler;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated; //直接设置index，不执行handler

@end
