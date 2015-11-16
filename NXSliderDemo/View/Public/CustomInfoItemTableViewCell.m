//
//  CustomInfoItemTableViewCell.m
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomInfoItemTableViewCell.h"
#import "SearchTipLabel.h"

@interface CustomInfoItemTableViewCell ()

@property (nonatomic, strong) SearchTipLabel *nameLabel;
@property (nonatomic, strong) SearchTipLabel *contentLabel;

@end

@implementation CustomInfoItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGFloat originX = [self originLeftX];
        CGFloat labelWidth = 70;
        _nameLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){originX, 0, labelWidth, customInfoItemTableViewCellHeight}];
        [_nameLabel setFont:[UIFont room107FontTwo]];
        [self addSubview:_nameLabel];
        
        originX += CGRectGetWidth(_nameLabel.bounds) + 10;
        _contentLabel = [[SearchTipLabel alloc] initWithFrame:(CGRect){originX, 0, CGRectGetWidth([self cellFrame]) - originX, customInfoItemTableViewCellHeight}];
        [_contentLabel setTextColor:[UIColor room107GrayColorD]];
        [self addSubview:_contentLabel];
    }
    
    return self;
}

- (CGRect)cellFrame {
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, customInfoItemTableViewCellHeight);
}

- (void)setNameLabelWidth:(CGFloat)width {
    [_nameLabel setFrame:(CGRect){_nameLabel.frame.origin, width, _nameLabel.frame.size.height}];
    CGFloat originX = _nameLabel.frame.origin.x + width;
    [_contentLabel setFrame:(CGRect){originX, 0, CGRectGetWidth([self cellFrame]) - originX, customInfoItemTableViewCellHeight}];
}

- (void)setName:(NSString *)name {
    [_nameLabel setText:name];
}

- (void)setAttributedName:(NSMutableAttributedString *)name {
    [_nameLabel setAttributedText:name];
}

- (void)setContentX:(CGFloat)originX {
    [_contentLabel setFrame:(CGRect){originX, 0, CGRectGetWidth([self cellFrame]) - originX, customInfoItemTableViewCellHeight}];
}

- (void)setContent:(NSString *)content {
    [_contentLabel setText:content];
    [_contentLabel setTextColor:[UIColor room107GrayColorD]];
}

- (void)setContentColor:(UIColor *)color {
    [_contentLabel setTextColor:color];
}

- (void)setAttributedContent:(NSMutableAttributedString *)content {
    [_contentLabel setAttributedText:content];
}

@end
