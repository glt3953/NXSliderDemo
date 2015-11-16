//
//  ProcedureItemView.h
//  room107
//
//  Created by ningxia on 15/7/10.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcedureItemView : UIView

- (id)initWithFrame:(CGRect)frame andOrder:(NSUInteger)order andTitle:(NSString *)title;
- (void)setSelected:(BOOL)selected;

@end
