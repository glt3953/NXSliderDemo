//
//  CustomTextView.m
//  room107
//
//  Created by ningxia on 15/7/25.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomTextView.h"
@interface CustomTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation CustomTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
        self.dataDetectorTypes = UIDataDetectorTypeAll; //使用UIDataDetectorTypes自动检测电话、网址和邮箱
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setFont:[UIFont room107SystemFontThree]];
        self.textColor = [UIColor room107GrayColorD];
        [self setTintColor:[UIColor room107GreenColor]];
        self.alwaysBounceHorizontal = NO;
        
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self showPlaceholder:text.length == 0 ? YES : NO];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self showPlaceholder:attributedText.length == 0 ? YES : NO];
}

- (NSDictionary *)attributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:self.font,
                                 NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:self.textColor};
    
    return attributes;
}

- (CGRect)getContentRectWithText:(NSString *)text {
    CGRect contentRect = [text boundingRectWithSize:(CGSize){CGRectGetWidth(self.frame), MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:[self attributes] context:nil];
    
    return contentRect;
}

- (void)showPlaceholder:(BOOL)isShow {
    if (!self.placeholderLabel) {
        CGFloat offset = 5.0f;
        CGRect frame = CGRectMake(offset, 1.5 * offset, CGRectGetWidth(self.bounds) - 2 * offset, CGRectGetHeight(self.bounds) - 4 * offset);
        self.placeholderLabel = [[UILabel alloc] initWithFrame:frame];
//        self.placeholderLabel.editable = NO;
//        self.placeholderLabel.scrollEnabled = NO;
        [self.placeholderLabel setNumberOfLines:0];
        [self.placeholderLabel setTextAlignment:NSTextAlignmentLeft];
        [self.placeholderLabel setBackgroundColor:[UIColor clearColor]];
        [self.placeholderLabel setFont:self.font];
        [self.placeholderLabel setTextColor:[UIColor room107GrayColorB]];
        [self addSubview:self.placeholderLabel];
    }
    
    self.placeholderLabel.hidden = !isShow;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [self showPlaceholder:YES];
    
    CGFloat offset = 5.0f;
    float maxMessageDisplayWidth = CGRectGetWidth(self.bounds) - 2 * offset;
    CGRect contentRect = [placeholder boundingRectWithSize:(CGSize){maxMessageDisplayWidth, MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    [self.placeholderLabel setFrame:(CGRect){self.placeholderLabel.frame.origin, contentRect.size}];
    [self.placeholderLabel setText:placeholder];
//    _placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:placeholder attributes:[self attributes]];
}

- (void)setFontSize:(CGFloat)size {
    [self setFont:[UIFont systemFontOfSize:size]];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:[self attributes]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        //表示输入的是退格键，输入的是第一个字符
        _placeholderLabel.hidden = NO;
    }
    
    return YES;
}

@end
