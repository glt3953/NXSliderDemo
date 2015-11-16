//
//  DatePickerTableViewCell.h
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107TableViewCell.h"

static CGFloat datePickerTableViewCellHeight = 175.0f;

@interface DatePickerTableViewCell : Room107TableViewCell

- (void)setTips:(NSString *)tips;
- (void)setDate:(NSString *)date;
- (NSString *)dateString;

@end
