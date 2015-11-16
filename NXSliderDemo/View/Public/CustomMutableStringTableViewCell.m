//
//  CustomMutableStringTableViewCell.m
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomMutableStringTableViewCell.h"
#import "NSString+AttributedString.h"

@interface CustomMutableStringTableViewCell ()

@property (nonatomic, strong) SearchTipLabel *contentLabel;
@property (nonatomic, strong) void (^viewHandlerBlock)();

@end

@implementation CustomMutableStringTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _contentLabel = [[SearchTipLabel alloc] init];
        [self addSubview:_contentLabel];
        UITapGestureRecognizer *tapGestureRecgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentDidClick)];
        _contentLabel.userInteractionEnabled = YES;
        [_contentLabel addGestureRecognizer:tapGestureRecgnizer];
    }
    
    return self;
}

- (void)setContent:(NSString *)content {
    CGRect contentRect = [self getContentRectWithContent:content];
    CGFloat originY = [self originTopY] + [self titleHeight] + 10;
    [_contentLabel setFrame:(CGRect){([[UIScreen mainScreen] bounds].size.width - contentRect.size.width) / 2, originY, contentRect.size}];
}

- (void)setContent:(NSString *)content withAlignment:(NSTextAlignment)textAlignment {
    [_contentLabel setText:content];
    [_contentLabel setTextAlignment:textAlignment];
    [_contentLabel setFrame:(CGRect){[self originLeftX], 0, [[UIScreen mainScreen] bounds].size.width - 2 * [self originLeftX], 40}];
}

- (void)setContentColor:(UIColor *)color {
    [_contentLabel setTextColor:color];
}

- (CGFloat)getCellHeightWithContent:(NSString *)content {
    CGRect contentRect = [self getContentRectWithContent:content];
    
    CGFloat originY = [self originTopY] + [self titleHeight] + 10;
    return originY + contentRect.size.height;
}

- (CGRect)getContentRectWithContent:(NSString *)content {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:_contentLabel.font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect contentRect = [content boundingRectWithSize:(CGSize){[[UIScreen mainScreen] bounds].size.width - [self originLeftX], MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:content ? content : @"" attributes:attributes];
    return contentRect;
}

- (void)setViewDidClickHandler:(void(^)())handler {
    _viewHandlerBlock = handler;
}

- (void)contentDidClick {
    if (_viewHandlerBlock) {
        _viewHandlerBlock();
    }
}

@end
