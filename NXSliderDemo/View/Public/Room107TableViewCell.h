//
//  Room107TableViewCell.h
//  room107
//
//  Created by ningxia on 15/7/31.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTipLabel.h"

@interface Room107TableViewCell : UITableViewCell

@property (nonatomic, strong) SearchTipLabel *titleLabel;
- (CGFloat)originLeftX;
- (CGFloat)originTopY;
- (CGFloat)originBottomY;
- (CGFloat)titleHeight;
- (void)setTitle:(NSString *)title;

@end
