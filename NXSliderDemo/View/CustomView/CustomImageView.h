//
//  CustomImageView.h
//  room107
//
//  Created by ningxia on 15/7/3.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView

- (void)setImageWithURL:(NSString *)url;
- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
- (void)setImageWithName:(NSString *)name;
- (void)setCornerRadius:(CGFloat)cornerRadius;

- (void)setImageWithURL:(NSString *)url withCompletionHandler:(void(^)(UIImage *image))completionHandler;

@end
