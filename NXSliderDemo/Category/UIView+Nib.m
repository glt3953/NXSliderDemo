//
//  UIView+Nib.m
//  room107
//
//  Created by ningxia on 15/6/25.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)
+ (instancetype)createViewFromNib {
    NSString *nibName = NSStringFromClass(self.class);
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    if ([nibs count] > 0) {
        for (UIView *view in nibs) {
            if ([NSStringFromClass([view class]) isEqual:nibName]) {
                return view;
            }
        }
    }
    
    return nil;
}

+ (UINib *)createNibFromNib {
    return [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
}

- (void)storyBoardImportNibLoadNib{
    NSString *nibName = NSStringFromClass(self.class);
    [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
}

@end
