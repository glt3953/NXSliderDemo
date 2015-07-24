//
//  ScrollViewController.m
//  Sample
//
//  Created by Wenchao Ding on 1/24/15.
//  Copyright (c) 2015 DZN Labs. All rights reserved.
//

#import "ScrollViewController.h"
#import "DZNSegmentedControl.h"
#import "UIScrollView+DZNSegmentedControl.h"

@interface ScrollViewController () <DZNSegmentedControlDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DZNSegmentedControl *segmentedControl;

@end

@implementation ScrollViewController

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    self.title = NSStringFromClass([DZNSegmentedControl class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat colorValue = 238.0f/255.0f;
    [self.view setBackgroundColor:[UIColor colorWithRed:colorValue green:colorValue blue:colorValue alpha:1.0f]];
    
    CGRect frame = self.view.frame;
    frame.origin.y += 20.0f + 40.0f;
    frame.size.height -= 20.0f + 40.0f;
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES; //支持左右滑动时segmentedControl跟着一起走
    [self.view addSubview:_scrollView];
    
    frame.size.height = 40.0f;
    self.segmentedControl = [[DZNSegmentedControl alloc] initWithFrame:frame];
    self.segmentedControl.items = @[@"邮箱认证", @"证件认证"];
    self.segmentedControl.showsCount = NO;
    self.segmentedControl.autoAdjustSelectionIndicatorWidth = NO;
    [self.segmentedControl setTintColor:[UIColor colorWithRed:50/255.0f green:174/255.0f blue:153/255.0f alpha:1.0f]];
    [self.segmentedControl setNormalColor:[UIColor lightGrayColor]];
    [self.view addSubview:_segmentedControl];
    self.scrollView.segmentedControl = self.segmentedControl;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    self.scrollView.frame = [UIScreen mainScreen].bounds;
//    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    __block CGFloat originX = 0.0;
    
    [self.segmentedControl.items enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        CGRect frame = _scrollView.frame;
        frame.origin.x = originX;
        frame.origin.y = 0;
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = (idx%2 == 0) ? [UIColor redColor] : [UIColor blueColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:40];
        label.text = name;
        
        [self.scrollView addSubview:label];
        
        originX += CGRectGetWidth(frame);
        
        
//        UILabel *subLabel = [[UILabel alloc] initWithFrame:(CGRect){0, 0, 10, 10}];
//        subLabel.textAlignment = NSTextAlignmentCenter;
//        [subLabel setTextColor:[UIColor blackColor]];
//        subLabel.font = [UIFont systemFontOfSize:15];
//        subLabel.numberOfLines = 0;
//        subLabel.text = @"介绍\n这篇文章主要是介绍一下我在iOS开发中使用到的一些可以提升开发效率的方法和工具。\nIDE\n首先要说的肯定是IDE了，说到IDE，Xcode不能跑，当然你也可能同时在使用AppCode等其他的IDE，在这里我主要介绍Xcode中提升开发效率的方法。\n1.善用快捷键\n快捷键是开发中必不可少的，当你善于使用快捷键的时候，十指在键盘上飞舞，那画面太美，我不敢想象。";
//        [label addSubview:subLabel];
//        [UIView animateWithDuration:1.5 animations:^{
//            [subLabel setFrame:(CGRect){0, 50, label.bounds.size}];
//        } completion:^(BOOL finished) {
////            [subLabel setFrame:(CGRect){0, 50, label.bounds.size}];
//        }];
    }];
    
    
    
    self.scrollView.contentSize = CGSizeMake(originX, self.scrollView.frame.size.height);
}


#pragma mark - Events

//- (IBAction)didChangeSegment:(id)sender {
//    NSLog(@"%s",__FUNCTION__);
//}


#pragma mark - View Auto-Rotation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


#pragma mark - View lifeterm

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}


@end
