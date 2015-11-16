//
//  Room107VisualEffectView.m
//  room107
//
//  Created by ningxia on 15/8/13.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107VisualEffectView.h"

@implementation Room107VisualEffectView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    if (self) {
        [self setFrame:frame];
    }
    
    return self;
}

@end
