//
//  CustomButton.h
//  room107
//
//  Created by ningxia on 15/6/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton + EnlargeTouchArea.h"

typedef enum {
    ShareToTypeWechat = 0, //
    ShareToTypeWechatMoments, //微信朋友圈
    ShareToTypeQQ, //
} ShareToType;

typedef enum {
    ContactOwnerTypeTelephone = 0, //
    ContactOwnerTypeQQ, //
    ContactOwnerTypeWechat, //
} ContactOwnerType;

@interface CustomButton : UIButton

- (void)setImageWithName:(NSString *)name;
- (void)setImageWithURL:(NSString *)url;
- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBackgroundColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
- (void)setFontSize:(CGFloat)size;

@end
