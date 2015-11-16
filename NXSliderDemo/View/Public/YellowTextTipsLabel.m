//
//  YellowTextTipsLabel.m
//  room107
//
//  Created by ningxia on 15/9/8.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "YellowTextTipsLabel.h"
#import "CircleGreenMarkView.h"

@implementation YellowTextTipsLabel

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setText:title];
        [self setTextColor:[UIColor room107YellowColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        
        CGRect contentRect = [title boundingRectWithSize:(CGSize){frame.size.width, MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
        
        CGFloat markViewWidth = 8;
        CircleGreenMarkView *markView = [[CircleGreenMarkView alloc] initWithFrame:(CGRect){(frame.size.width - contentRect.size.width) / 2 - markViewWidth, (CGRectGetHeight(self.bounds) - contentRect.size.height) / 2 + markViewWidth / 2, markViewWidth, markViewWidth}];
        [markView setBackgroundColor:[UIColor room107YellowColor]];
        [self addSubview:markView];
    }
    
    return self;
}

@end
