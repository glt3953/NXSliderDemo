//
//  CustomInfoItemTableViewCell.h
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107TableViewCell.h"

static CGFloat customInfoItemTableViewCellHeight = 40.0f;

@interface CustomInfoItemTableViewCell : Room107TableViewCell

- (void)setNameLabelWidth:(CGFloat)width;
- (void)setName:(NSString *)name;
- (void)setAttributedName:(NSMutableAttributedString *)name;
- (void)setContentX:(CGFloat)originX;
- (void)setContent:(NSString *)content;
- (void)setContentColor:(UIColor *)color;
- (void)setAttributedContent:(NSMutableAttributedString *)content;

@end
