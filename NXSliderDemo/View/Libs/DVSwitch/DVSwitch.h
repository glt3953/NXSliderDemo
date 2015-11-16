//
//  DVSwitch.h
//  DVSwitcherExample
//
//  Created by Dmitry Volevodz on 08.10.14.
//  Copyright (c) 2014 Dmitry Volevodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DVSwitchDelegate;

@interface DVSwitch : UIControl

@property (nonatomic, weak) id<DVSwitchDelegate> delegate;
@property (nonatomic, strong) UIColor *backgroundColor; // defaults to gray
@property (nonatomic, strong) UIColor *sliderColor; // defaults to white
@property (nonatomic, strong) UIColor *labelTextColorInsideSlider; // defaults to black
@property (nonatomic, strong) UIColor *labelTextColorOutsideSlider; // defaults to white
@property (nonatomic, strong) UIFont *fontInside; // default is nil
@property (nonatomic, strong) UIFont *fontOutside; // default is nil
@property (nonatomic) CGFloat cornerRadius; // defaults to 12
@property (nonatomic) CGFloat sliderOffset; // slider offset from background, top, bottom, left, right
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSString *selectedTitle;

+ (instancetype)switchWithStringsArray:(NSArray *)strings;
- (instancetype)initWithStringsArray:(NSArray *)strings;
- (instancetype)initWithAttributedStringsArray:(NSArray *)strings;

- (void)forceSelectedIndex:(NSInteger)index animated:(BOOL)animated; // sets the index, also calls handler block

// This method sets handler block that is getting called after the switcher is done animating the transition

- (void)setPressedHandler:(void (^)(NSUInteger index))handler;

// This method sets handler block that is getting called right before the switcher starts animating the transition

- (void)setWillBePressedHandler:(void (^)(NSUInteger index))handler;

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated; // sets the index without calling the handler block

- (void)layoutSubviews;

@end

@protocol DVSwitchDelegate <NSObject>

- (void)selectedIndexChanged:(DVSwitch *)DVSwitch;

@end
