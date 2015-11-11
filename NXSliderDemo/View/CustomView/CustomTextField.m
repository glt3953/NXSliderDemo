//
//  CustomTextField.m
//  room107
//
//  Created by ningxia on 15/7/10.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        UILabel *leftView = [[UILabel alloc] initWithFrame:(CGRect){self.bounds.origin, 20, CGRectGetHeight(self.bounds)}];
        leftView.backgroundColor = [UIColor clearColor];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.textAlignment = NSTextAlignmentLeft;
        [self setTextColor:[UIColor room107GrayColorD]];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //内容的垂直对齐方式
        self.backgroundColor = [UIColor whiteColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self setFont:[UIFont room107FontThree]];
        [self setTintColor:[UIColor room107GreenColor]];
    }
    
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor room107GrayColorB]}];
}

- (void)setFontSize:(CGFloat)size {
    self.font = [UIFont systemFontOfSize:size];
}

- (void)setLeftViewWidth:(CGFloat)width {
    [self.leftView setFrame:(CGRect){self.leftView.bounds.origin, width, self.leftView.bounds.size.height}];
}

@end
