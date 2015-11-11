//
//  UIColor++Room107.h
//  room107
//
//  Created by ningxia on 15/6/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Room107)

+ (NSDictionary *)rgbFromHexString:(NSString *)hexString;

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)alpha;

+ (UIColor *)colorWithKey:(NSString *)key;

+ (UIColor *)colorWithCircleImageByKey:(NSString *)key radius:(CGFloat)radius;

+ (UIColor *)colorWithCircleImageWithColor:(UIColor *)color radius:(CGFloat)radius;

+ (UIColor *)room107GreenColor;

+ (UIColor *)room107GrayColorA;

+ (UIColor *)room107GrayColorB;

+ (UIColor *)room107GrayColorC;

+ (UIColor *)room107GrayColorD;

+ (UIColor *)room107ViewBackgroundColor;

+ (UIColor *)room107YellowColor;

+ (UIColor *)room107pinkColor;

+ (UIColor *)room107BlueColor;
@end
