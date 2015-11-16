//
//  CustomMutableStringTableViewCell.h
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107TableViewCell.h"

@interface CustomMutableStringTableViewCell : Room107TableViewCell

- (void)setContentColor:(UIColor *)color;
- (void)setContent:(NSString *)content;
- (void)setContent:(NSString *)content withAlignment:(NSTextAlignment)textAlignment;
- (CGFloat)getCellHeightWithContent:(NSString *)content;
- (void)setViewDidClickHandler:(void(^)())handler;

@end
