//
//  NYDatePicker.m
//  DatePickerDemo
//
//  Created by Naitong Yu on 15/8/4.
//  Copyright (c) 2015年 107间. All rights reserved.
//

#import "NYDatePicker.h"
#import "NYPickerComponent.h"

@interface NYDatePicker ()

@property (nonatomic) NYPickerComponent *yearComponent;
@property (nonatomic) NYPickerComponent *monthComponent;
@property (nonatomic) NYPickerComponent *dayComponnent;

@property (nonatomic) UILabel *yearLabel;
@property (nonatomic) UILabel *monthLabel;
@property (nonatomic) UILabel *dayLabel;

@property (nonatomic) UIFont *labelFont;
@property (nonatomic) NSInteger startYear; //开始年份，即当前年的前50年

@property (nonatomic) NSCalendar *calendar;
@property (nonatomic) NSDateComponents *components;

@property (nonatomic, strong) void(^dateDidChangeHandler)(NSDate *date);

@end

@implementation NYDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _font = [UIFont systemFontOfSize:self.frame.size.height * 2 / 9];
    _color = [UIColor blackColor];
    self.clipsToBounds = YES;
    
    self.calendar = [NSCalendar currentCalendar];
    self.components = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSInteger year = [self.components year];
    NSInteger month = [self.components month];
    NSInteger day = [self.components day];
    
    self.startYear = year - 50;
    NSMutableArray *yearArray = [[NSMutableArray alloc] initWithCapacity:100];
    for (NSInteger i = 0; i < 100; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld", (long)(i + self.startYear)]];
    }
    _yearComponent = [[NYPickerComponent alloc] initWithFrame:CGRectZero andStringsArray:yearArray];
    _yearComponent.textColor = self.color;
    _yearComponent.font = self.font;
    [_yearComponent setSelectedIndex:year - self.startYear animated:NO];
    __weak __typeof(self) weakSelf = self;
    [_yearComponent setIndexDidChangeHandler:^(NSInteger index) {
        weakSelf.components.year = weakSelf.startYear + index;
        [weakSelf dayLengthChanged];
        if (weakSelf.dateDidChangeHandler) {
            weakSelf.dateDidChangeHandler(weakSelf.date);
        }
    }];
    [self addSubview:_yearComponent];
    
    NSMutableArray *monthArray = [[NSMutableArray alloc]initWithCapacity:12];
    for (NSInteger i = 1; i <= 12; i++) {
        [monthArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    _monthComponent = [[NYPickerComponent alloc] initWithFrame:CGRectZero andStringsArray:monthArray];
    _monthComponent.textColor = self.color;
    _monthComponent.font = self.font;
    [_monthComponent setSelectedIndex:month - 1 animated:NO];
    [_monthComponent setIndexDidChangeHandler:^(NSInteger index) {
        weakSelf.components.month = index + 1;
        [weakSelf dayLengthChanged];
        if (weakSelf.dateDidChangeHandler) {
            weakSelf.dateDidChangeHandler(weakSelf.date);
        }
    }];
    [self addSubview:_monthComponent];
    
    NSMutableArray *dayArray = [[NSMutableArray alloc] initWithCapacity:31];
    NSInteger dayLength = [self dayLength];
    for (NSInteger i = 1; i <= dayLength; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    _dayComponnent = [[NYPickerComponent alloc] initWithFrame:CGRectZero andStringsArray:dayArray];
    _dayComponnent.textColor = self.color;
    _dayComponnent.font = self.font;
    [_dayComponnent setSelectedIndex:day - 1 animated:NO];
    [_dayComponnent setIndexDidChangeHandler:^(NSInteger index) {
        weakSelf.components.day = index + 1;
        if (weakSelf.dateDidChangeHandler) {
            weakSelf.dateDidChangeHandler(weakSelf.date);
        }
    }];
    [self addSubview:_dayComponnent];
    
    _labelFont = [self.font fontWithSize:self.font.pointSize / 2];
    _yearLabel = [[UILabel alloc] init];
    _yearLabel.text = @"年";
    _yearLabel.font = self.labelFont;
    _yearLabel.textColor = self.color;
    _yearLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_yearLabel];
    _monthLabel = [[UILabel alloc] init];
    _monthLabel.text = @"月";
    _monthLabel.font = self.labelFont;
    _monthLabel.textColor = self.color;
    _monthLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_monthLabel];
    _dayLabel = [[UILabel alloc] init];
    _dayLabel.text = @"日";
    _dayLabel.font = self.labelFont;
    _dayLabel.textColor = self.color;
    _dayLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_dayLabel];
    
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat labelWidth = self.labelFont.pointSize / 2 * 3;
    CGFloat yearWidth = self.font.pointSize * 2.5;
    CGFloat monthWidth = yearWidth / 2;
    CGFloat dayWidth = yearWidth / 2;
    CGFloat marginWidth = (width - yearWidth - monthWidth - dayWidth - 3 * labelWidth) / 2;
    
    [self.yearComponent setFrame:CGRectMake(0, 0, yearWidth, height)];
    [self.yearLabel setFrame:CGRectMake(yearWidth, 0, labelWidth, height)];
    [self.monthComponent setFrame:CGRectMake(yearWidth + labelWidth + marginWidth, 0, monthWidth, height)];
    [self.monthLabel setFrame:CGRectMake(yearWidth + labelWidth + marginWidth + monthWidth, 0, labelWidth, height)];
    [self.dayComponnent setFrame:CGRectMake(width - dayWidth - labelWidth, 0, dayWidth, height)];
    [self.dayLabel setFrame:CGRectMake(width - labelWidth, 0, labelWidth, height)];
    
}

- (void)dayLengthChanged {
    NSInteger oldDayLength = self.dayComponnent.strings.count;
    if (oldDayLength != [self dayLength]) {
        NSMutableArray *dayArray = [[NSMutableArray alloc] initWithCapacity:31];
        NSInteger dayLength = [self dayLength];
        for (NSInteger i = 1; i <= dayLength; i++) {
            [dayArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        [self.dayComponnent setStrings:dayArray];
        if (self.components.day > dayLength) {
            self.components.day = dayLength;
        }
    }
}

- (NSInteger)dayLength {
    NSDateComponents *dateComponents = [self.components copy];
    dateComponents.day = 1;
    dateComponents.calendar = self.calendar;
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateComponents.date];
    return range.length;
}

- (NSDate *)date {
    return [self.calendar dateFromComponents:self.components];
}

- (void)setDate:(NSDate *)date {
    self.components = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [self.yearComponent setSelectedIndex:self.components.year - self.startYear animated:YES];
    [self.monthComponent setSelectedIndex:self.components.month - 1 animated:YES];
    [self dayLengthChanged];
    [self.dayComponnent setSelectedIndex:self.components.day - 1 animated:YES];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.yearComponent.font = font;
    self.monthComponent.font = font;
    self.dayComponnent.font = font;
    
    self.labelFont = [font fontWithSize:font.pointSize / 2];
    self.yearLabel.font = self.labelFont;
    self.monthLabel.font = self.labelFont;
    self.dayLabel.font = self.labelFont;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.yearComponent.textColor = color;
    self.monthComponent.textColor = color;
    self.dayComponnent.textColor = color;
    self.yearLabel.textColor = color;
    self.monthLabel.textColor = color;
    self.dayLabel.textColor = color;
}

@end
