//
//  StatusBarView.m
//  room107
//
//  Created by ningxia on 15/7/17.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "StatusBarView.h"

@implementation StatusBarView

+ (instancetype)newView {
    return [[StatusBarView alloc] init];
}

- (instancetype)init {
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.height = statusBarHeight;
    self = [[StatusBarView alloc] initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor room107GreenColor]];
    }
    
    return self;
}

@end
