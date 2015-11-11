//
//  UIColor++Room107.m
//  room107
//
//  Created by ningxia on 15/6/24.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "UIColor+Room107.h"
#import "UIImage+Room107.h"

@implementation UIColor (Room107)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (NSDictionary *)rgbFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return @{@"red":@(((rgbValue & 0xFF0000) >> 16)) , @"green" : @(((rgbValue & 0xFF00) >> 8)) ,
             @"blue":@((rgbValue & 0xFF)) };
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(float)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

+ (UIColor *)colorWithKey:(NSString *)key {
    static NSDictionary *colorDictionary = nil;
    if (colorDictionary == nil) {
        // TODO:通过配置文件初始化颜色键值对
        colorDictionary = @{@"a":[self colorFromHexString:@"#4b81ca"],
                            @"b":[self colorFromHexString:@"#38b478"],
                            @"c":[self colorFromHexString:@"#e46933"],
                            @"d":[self colorFromHexString:@"#7badc0"],
                            @"e":[self colorFromHexString:@"#cacf3d"],
                            @"f":[self colorFromHexString:@"#77af4a"],
                            @"S":[self colorFromHexString:@"#ff8400"],
                            @"W":[self colorFromHexString:@"#0658a3"],
                            @"T":[self colorFromHexString:@"#86c927"],
                            @"E":[self colorFromHexString:@"#009cff"]};
    }
    
    return colorDictionary[key];
}

+ (UIColor *)colorWithCircleImageByKey:(NSString *)key radius:(CGFloat)radius {
    UIColor *color = [self colorWithKey:key];
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    
    return [UIColor colorWithPatternImage:[UIImage makeCircleImageWithColor:color radius:radius]];
}

+ (UIColor *)colorWithCircleImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    return [UIColor colorWithPatternImage:[UIImage makeCircleImageWithColor:color radius:radius]];
}

+ (UIColor *)room107GreenColor {
    return [UIColor colorFromHexString:@"#00ac97"];
}

+ (UIColor *)room107GrayColorA {
    return [UIColor colorFromHexString:@"#f1f1f1"];
}

+ (UIColor *)room107GrayColorB {
    return [UIColor colorFromHexString:@"#e4e4e4"];
}

+ (UIColor *)room107GrayColorC {
    return [UIColor colorFromHexString:@"#c9c9c9"];
}

+ (UIColor *)room107GrayColorD {
    return [UIColor colorFromHexString:@"#797979"];
}

+ (UIColor *)room107ViewBackgroundColor {
    return [UIColor colorFromHexString:@"#f1f1f1"];
}

+ (UIColor *)room107YellowColor {
    return [UIColor colorFromHexString:@"#ffbc00"];
}

+ (UIColor *)room107pinkColor {
    return [UIColor colorFromHexString:@"#ff8080"];
}

+ (UIColor *)room107BlueColor {
    return [UIColor colorFromHexString:@"#199bff"];
}
@end
