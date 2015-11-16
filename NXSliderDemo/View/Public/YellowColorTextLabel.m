//
//  YellowColorTextLabel.m
//  room107
//
//  Created by ningxia on 15/8/26.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "YellowColorTextLabel.h"

@implementation YellowColorTextLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:[UIColor room107YellowColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont room107FontThree]];
        [self setNumberOfLines:0];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    return [self initWithFrame:frame withTitle:title withTitleColor:[UIColor room107YellowColor]];
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleColor:(UIColor *)color {
    self = [self initWithFrame:frame];
    
    if (self) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;// 字体的行间距
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSArray *components = [title componentsSeparatedByString:@" "];
        title = [title stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [(NSString *)components[0] length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [(NSString *)components[0] length])];
        if (components.count > 1) {
            paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 5;// 字体的行间距
            paragraphStyle.alignment = NSTextAlignmentLeft;
            [attributedString addAttribute:NSFontAttributeName value:[UIFont room107FontTwo] range:NSMakeRange([(NSString *)components[0] length], attributedString.length - [(NSString *)components[0] length])];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange([(NSString *)components[0] length], attributedString.length - [(NSString *)components[0] length])];
        }
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
        [self setAttributedText:attributedString];
    }
    
    return self;
}

@end
