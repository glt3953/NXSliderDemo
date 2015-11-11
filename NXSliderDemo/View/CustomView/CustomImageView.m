//
//  CustomImageView.m
//  room107
//
//  Created by ningxia on 15/7/3.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "CustomImageView.h"
//#import "UIImageView+WebCache.h"

@implementation CustomImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)setImageWithURL:(NSString *)url {
//    [self sd_setImageWithURL:[NSURL URLWithString:url]];
//    NSRange foundImageView2 = [url rangeOfString:imageView2Thumbnails options:NSCaseInsensitiveSearch];
//    NSRange foundImageMogr2 = [url rangeOfString:imageMogr2Thumbnails options:NSCaseInsensitiveSearch];
//    if(foundImageView2.length > 0 || foundImageMogr2.length > 0) {
//        [self sd_setImageWithURL:[NSURL URLWithString:url]];
//    } else {
//        //高度固定为suiteImageView高度，宽度等比缩小
//        [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAppendingString:[NSString stringWithFormat:@"%@%.f", imageView2Thumbnails, CGRectGetHeight(self.bounds)]]]];
//    }
}

- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder {
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
//    NSRange foundImageView2 = [url rangeOfString:imageView2Thumbnails options:NSCaseInsensitiveSearch];
//    NSRange foundImageMogr2 = [url rangeOfString:imageMogr2Thumbnails options:NSCaseInsensitiveSearch];
//    if(foundImageView2.length > 0 || foundImageMogr2.length > 0) {
//        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
//    } else {
//        //高度固定为suiteImageView高度，宽度等比缩小
//        [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAppendingString:[NSString stringWithFormat:@"%@%.f", imageView2Thumbnails, CGRectGetHeight(self.bounds)]]] placeholderImage:placeholder];
//    }
}

- (void)setImageWithURL:(NSString *)url withCompletionHandler:(void(^)(UIImage *image))completionHandler {
//    [self sd_setImageWithURL:[NSURL URLWithString:url]
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                       if (completionHandler) {
//                           completionHandler(image);
//                       }
//                   }];
//    [self sd_setImageWithURL:[NSURL URLWithString:[url stringByAppendingString:[NSString stringWithFormat:@"%@%.f", imageView2Thumbnails, CGRectGetHeight(self.bounds)]]]
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                       if (completionHandler) {
//                           completionHandler(image);
//                       }
//    }];
}

- (void)setImageWithName:(NSString *)name {
    [self setImage:[UIImage imageNamed:name]];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
