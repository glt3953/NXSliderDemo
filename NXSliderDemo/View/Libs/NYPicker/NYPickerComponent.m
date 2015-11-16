//
//  NYDateComponent.m
//  DatePickerDemo
//
//  Created by Naitong Yu on 15/8/5.
//  Copyright (c) 2015年 107间. All rights reserved.
//

#import "NYPickerComponent.h"

@interface NYPickerComponent ()

@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) UIView *sliderView;
@property (nonatomic, strong) void (^handlerBlock)(NSInteger index);

@end

@implementation NYPickerComponent

- (instancetype)init {
    self = [super init];
    if (self) {
        [NSException raise:@"NYPickerComponentException" format:@"Init call is prohibited, use initWithFrame:andStringsArray: method"];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andStringsArray:(NSArray *)strings {
    self = [super initWithFrame:frame];
    if (self) {
        _strings = strings;
        _selectedIndex = 0;
        _textColor = [UIColor room107GreenColor];
//        _font = [UIFont systemFontOfSize:self.frame.size.height / 3];
        _font = [UIFont room107FontFive];
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliderViewMoved:)];
        [self addGestureRecognizer:panRec];
        
        self.sliderView = [[UIView alloc] init];
        self.sliderView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.sliderView];
        
        self.labels = [[NSMutableArray alloc] initWithCapacity:self.strings.count];
        for (NSInteger i = 0; i < self.strings.count; i++) {
            NSString *string = self.strings[i];
            UILabel *label = [[UILabel alloc] init];
            label.tag = i;
            label.text = string;
            label.textColor = self.textColor;
            label.backgroundColor = [UIColor clearColor];
            label.font = self.font;
            label.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
            [label addGestureRecognizer:recognizer];
            [label setUserInteractionEnabled:YES];
            
            [self.sliderView addSubview:label];
            [self.labels addObject:label];
        }
    }
    return self;
}

+ (instancetype)pickerComponentWithFrame:(CGRect)frame andStringsArray:(NSArray *)strings {
    return [[self alloc] initWithFrame:frame andStringsArray:strings];
}

- (void)layoutSubviews {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat labelHeight = height / 3;
    
    self.sliderView.frame = CGRectMake(0, -labelHeight * (self.selectedIndex - 1), width, labelHeight * self.labels.count);
    
    for (NSInteger i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(0, i * labelHeight, width, labelHeight);
        if (i != self.selectedIndex) {
            label.transform = CGAffineTransformMakeScale(0.6, 0.6);
            label.alpha = 0.5;
        } else {
            label.transform = CGAffineTransformIdentity;
            label.alpha = 1.0;
        }
    }
}

- (void)animateChangeToIndex:(NSInteger)selectedIndex withTime:(NSTimeInterval)timeInterval completionHandler:(void (^)(BOOL finished))completion {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat labelHeight = height / 3;
    
    [UIView animateWithDuration:timeInterval delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.sliderView.frame = CGRectMake(0, -labelHeight * (selectedIndex - 1), width, labelHeight * self.labels.count);
        
        for (NSInteger i = 0; i < self.labels.count; i++) {
            UILabel *label = self.labels[i];
            if (i != selectedIndex) {
                label.transform = CGAffineTransformMakeScale(0.6, 0.6);
                label.alpha = 0.5;
            } else {
                label.transform = CGAffineTransformIdentity;
                label.alpha = 1.0;
            }
        }
    } completion:completion];
}


- (void)directlySetSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat labelHeight = height / 3;
    
    self.sliderView.frame = CGRectMake(0, -labelHeight * (selectedIndex - 1), width, labelHeight * self.labels.count);
    
    for (NSInteger i = 0; i < self.labels.count; i++) {
        UILabel *label = self.labels[i];
        if (i != selectedIndex) {
            label.transform = CGAffineTransformMakeScale(0.6, 0.6);
            label.alpha = 0.5;
        } else {
            label.transform = CGAffineTransformIdentity;
            label.alpha = 1.0;
        }
    }
}

- (void)handleTapOnLabel:(UITapGestureRecognizer *)recognizer {
    self.selectedIndex = recognizer.view.tag;
}

- (void)sliderViewMoved:(UIPanGestureRecognizer *)recognizer {

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint transition = [recognizer translationInView:self];
        CGRect oldFrame = self.sliderView.frame;
        self.sliderView.frame = CGRectMake(0, oldFrame.origin.y + transition.y, oldFrame.size.width, oldFrame.size.height);
        [recognizer setTranslation:CGPointZero inView:self];
        CGFloat labelHeight = self.frame.size.height / 3;
        
        CGFloat maxY = labelHeight + labelHeight;
        CGFloat minY = labelHeight - (self.labels.count) * labelHeight;
        
        if (self.sliderView.frame.origin.y < minY) {
            self.sliderView.frame = CGRectMake(0, minY, oldFrame.size.width, oldFrame.size.height);
        } else if (self.sliderView.frame.origin.y > maxY) {
            self.sliderView.frame = CGRectMake(0, maxY, oldFrame.size.width, oldFrame.size.height);
        }
        
        CGFloat yBeginScale = labelHeight / 2;
        CGFloat yMaxScale = yBeginScale + labelHeight;
        CGFloat yEndScale = yMaxScale + labelHeight;
        
        for (UILabel *label in self.labels) {
            CGPoint center = [self.sliderView convertPoint:label.center toView:self];
            if (center.y > yBeginScale && center.y <= yMaxScale) {
                CGFloat delta = (center.y - yBeginScale) / labelHeight;
                label.alpha = 0.5 + 0.5 * delta;
                label.transform = CGAffineTransformMakeScale(0.5 + 0.5 * delta, 0.5 + 0.5 * delta);
            } else if (center.y > yMaxScale && center.y <= yEndScale) {
                CGFloat delta = (center.y - yMaxScale) / labelHeight;
                label.alpha = 1.0 - 0.5 * delta;
                label.transform = CGAffineTransformMakeScale(1.0 - 0.5 * delta, 1.0 - 0.5 * delta);
            }
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateFailed) {
        CGFloat yCenter = self.frame.size.height / 2;
        CGFloat labelHeight = self.frame.size.height / 3;
        
        CGFloat maxY = labelHeight;
        CGFloat minY = labelHeight - (self.labels.count - 1) * labelHeight;
        
        if (self.sliderView.frame.origin.y < minY) {
            self.selectedIndex = self.labels.count - 1;
        } else if (self.sliderView.frame.origin.y > maxY) {
            self.selectedIndex = 0;
        } else {
            for (NSInteger i = 0; i < self.labels.count; i++) {
                UILabel *label = self.labels[i];
                CGPoint center = [self.sliderView convertPoint:label.center toView:self];
                if (fabs(center.y - yCenter) <= labelHeight / 2) {
                    self.selectedIndex = i;
                    break;
                }
            }
        }
    }
}


- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (UILabel *label in self.labels) {
        label.textColor = textColor;
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    for (UILabel *label in self.labels) {
        label.font = font;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex == _selectedIndex) {
        [self animateChangeToIndex:selectedIndex withTime:0.15 completionHandler:nil];
    } else {
        _selectedIndex = selectedIndex;
        [self animateChangeToIndex:selectedIndex withTime:0.15 completionHandler:^(BOOL finished) {
            if (self.handlerBlock) {
                self.handlerBlock(selectedIndex);
            }
        }];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    //去掉动画效果，避免设置不起作用
//    if (animated) {
//        [self animateChangeToIndex:selectedIndex withTime:0.15 completionHandler:nil];
//    } else {
        [self directlySetSelectedIndex:selectedIndex];
//    }
}

- (void)setStrings:(NSArray *)strings {
    _strings = strings;
    if (strings.count < self.labels.count) {
        if (self.selectedIndex >= strings.count) {
            _selectedIndex = strings.count - 1;
            [self animateChangeToIndex:_selectedIndex withTime:0.15 completionHandler:^(BOOL finished) {
                while (strings.count != self.labels.count) {
                    UILabel *last = [self.labels lastObject];
                    [last removeFromSuperview];
                    [self.labels removeLastObject];
                }
                if (self.handlerBlock) {
                    self.handlerBlock(_selectedIndex);
                }
            }];
        } else {
            while (strings.count != self.labels.count) {
                UILabel *last = [self.labels lastObject];
                [last removeFromSuperview];
                [self.labels removeLastObject];
            }
        }
    } else if (strings.count > self.labels.count) {
        while (strings.count != self.labels.count) {
            UILabel *label = [[UILabel alloc] init];
            label.tag = self.labels.count;
            label.textColor = self.textColor;
            label.backgroundColor = [UIColor clearColor];
            label.font = self.font;
            label.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
            [label addGestureRecognizer:recognizer];
            [label setUserInteractionEnabled:YES];
            
            [self.sliderView addSubview:label];
            [self.labels addObject:label];
        }
    }
    [self setNeedsLayout];
    
    for (NSInteger i = 0; i < _strings.count; i++) {
        UILabel *label = self.labels[i];
        label.text = _strings[i];
    }
}

- (void)setIndexDidChangeHandler:(void(^)(NSInteger index))handler {
    self.handlerBlock = handler;
}

@end
