//
//  Room107TableViewCell.m
//  room107
//
//  Created by ningxia on 15/7/31.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107TableViewCell.h"

@implementation Room107TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:[UIColor clearColor]];
        
//        _titleLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){[self originLeftX], [self originTopY], 240, [self titleHeight]}];
        _titleLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){[self originLeftX], [self originTopY], [[UIScreen mainScreen] bounds].size.width - 2 * [self originLeftX], [self titleHeight]}];
        [_titleLabel setFont:[UIFont room107FontTwo]];
        [self addSubview:_titleLabel];
        _titleLabel.hidden = YES;
    }
    
    return self;
}

- (CGFloat)originLeftX {
    return 22.0f;
}

- (CGFloat)originTopY {
    return 0.0f;
}

- (CGFloat)originBottomY {
    return 33.0f;
}

- (CGFloat)titleHeight {
    return 25.0f;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.hidden = NO;
    [_titleLabel setText:title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
