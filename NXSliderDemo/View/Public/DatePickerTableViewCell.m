//
//  DatePickerTableViewCell.m
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "DatePickerTableViewCell.h"
#import "NYDatePicker.h"
#import "NSString+Valid.h"

@interface DatePickerTableViewCell ()

@property (nonatomic, strong) SearchTipLabel *tipsLabel;
@property (nonatomic, strong) NYDatePicker *datePicker;

@end

@implementation DatePickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat originY = [self originTopY] + [self titleHeight];
        _tipsLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){[self originLeftX], originY, CGRectGetWidth([self cellFrame]) - 2 * [self originLeftX], [self titleHeight]}];
        [_tipsLabel setFont:[UIFont room107FontTwo]];
        [self addSubview:_tipsLabel];

        originY += CGRectGetHeight(_tipsLabel.bounds);
        _datePicker = [[NYDatePicker alloc] initWithFrame:(CGRect){[self originLeftX], originY, CGRectGetWidth([self cellFrame]) - 2 * [self originLeftX], 100}];
        [_datePicker setFont:[UIFont systemFontOfSize:CGRectGetHeight(_datePicker.bounds) / 3]];
        [_datePicker setColor:[UIColor room107GreenColor]];
        [self addSubview:_datePicker];
    }
    
    return self;
}

- (CGRect)cellFrame {
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, datePickerTableViewCellHeight);
}

- (void)setTips:(NSString *)tips {
    [_tipsLabel setText:tips];
}

- (void)setDate:(NSString *)date {
    if (date && ![date isEmpty]) {
        _datePicker.date = [TimeUtil getDateFromFormatString:date withDateFormat:dateFormatForJSON];
    }
}

- (NSString *)dateString {
    return [TimeUtil getFormatDateStringFromDate:_datePicker.date withDateFormat:dateFormatForJSON];
}

@end
