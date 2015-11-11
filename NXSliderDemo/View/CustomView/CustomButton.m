//
//  CustomButton.m
//  room107
//
//  Created by ningxia on 15/6/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomButton.h"
//#import "UIButton+WebCache.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor room107GreenColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont room107FontSix]];
        [self setEnlargeEdgeWithTop:5 right:5 bottom:5 left:5];
    }
    
    return self;
}

- (void)setImageWithName:(NSString *)name {
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

- (void)setImageWithURL:(NSString *)url {
//    [self sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
//    NSRange foundImageView2 = [url rangeOfString:imageView2Thumbnails options:NSCaseInsensitiveSearch];
//    NSRange foundImageMogr2 = [url rangeOfString:imageMogr2Thumbnails options:NSCaseInsensitiveSearch];
//    if(foundImageView2.length > 0 || foundImageMogr2.length > 0) {
//        [self sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
//    } else {
//        //高度固定为suiteImageView高度，宽度等比缩小
//        [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAppendingString:[NSString stringWithFormat:@"%@%.f", imageView2Thumbnails, CGRectGetHeight(self.bounds)]]] forState:UIControlStateNormal];
//    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBackgroundColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    [self setBackgroundColor:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f]];
}

- (void)setFontSize:(CGFloat)size {
    [self.titleLabel setFont:[UIFont fontWithName:fontIconName size:size]];
}

@end
