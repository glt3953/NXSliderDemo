//
//  ViewController.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/16.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "ViewController.h"
#import "NXRangeSlider.h"
#import "FirstPushViewController.h"

static CGFloat unitFontSize = 10.0f;
static CGFloat priceFontSize = 15.0f;

@interface ViewController () <NXRangeSliderDelegate>

@property (nonatomic,strong) NXRangeSlider *priceSlider;
@property (nonatomic,strong) UILabel *leftPriceLabel;
@property (nonatomic,strong) UILabel *rightPriceLabel;
@property (nonatomic) CGFloat trueDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.view setBackgroundColor:[UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    CGFloat spaceX = 20;
    _priceSlider = [[NXRangeSlider alloc] initWithFrame:CGRectMake(spaceX, 150, CGRectGetWidth(self.view.bounds) - 2 * spaceX, 50)];
    _priceSlider.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.0f];
    _priceSlider.rangeSliderDelegate = self;
    _priceSlider.minValue = 0;
    _priceSlider.maxValue = 10000;
    _priceSlider.leftValue = 0;
    _priceSlider.rightValue = 10000;
    _priceSlider.minValueRange = 100;
    _priceSlider.shadowRadius = 3.0f;
    [self.view addSubview:_priceSlider];
    
    UIColor *color = [UIColor colorWithRed:50/255.0f green:174/255.0f blue:153/255.0f alpha:1.0f];
    _leftPriceLabel = [[UILabel alloc] init];
    [_leftPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_leftPriceLabel setTextColor:color];
    [self.view addSubview:_leftPriceLabel];
    
    _rightPriceLabel = [[UILabel alloc] init];
    [_rightPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_rightPriceLabel setTextColor:color];
    [self.view addSubview:_rightPriceLabel];
    
//    self.view.layer.cornerRadius = 10.0f;
//    self.view.layer.masksToBounds = YES;
    //添加阴影效果
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(-10, 10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
    self.view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.view.layer.shadowRadius = 10.0f; //阴影半径
    
    CGRect frame = (CGRect){22, 300, 60, 30};
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:@"jump" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (IBAction)buttonDidClick:(id)sender {
    NSLog(@"self.navigationController:%@", self.navigationController);
    FirstPushViewController *firstPushViewController = [[FirstPushViewController alloc] init];
    [self.navigationController pushViewController:firstPushViewController animated:YES];
    NSLog(@"self.navigationController.viewControllers:%@", self.navigationController.viewControllers);
}

- (IBAction)menuButtonDidClick:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WLRangeSliderDelegate

- (void)leftValueDidChange:(NXRangeSlider *)slider {
    if ([slider isEqual:_priceSlider]) {
        int value = _priceSlider.leftValue / _priceSlider.minValueRange;
        value *= _priceSlider.minValueRange;
        NSMutableAttributedString *attributedString = [self attributedStringFromValue:value];
        
        CGFloat leftSliderCenter = [_priceSlider leftSliderCenter];
        [_leftPriceLabel setFrame:(CGRect){_priceSlider.bounds.origin.x + leftSliderCenter, _priceSlider.frame.origin.y + CGRectGetHeight(_priceSlider.bounds) + 10, attributedString.size}];
        [_leftPriceLabel setCenter:CGPointMake(leftSliderCenter + CGRectGetHeight(_priceSlider.bounds) / 2, _leftPriceLabel.center.y)];
        [_leftPriceLabel setAttributedText:attributedString];
    }
}

- (void)rightValueDidChange:(NXRangeSlider *)slider {
    if ([slider isEqual:_priceSlider]) {
        int value = _priceSlider.rightValue / _priceSlider.minValueRange;
        value *= _priceSlider.minValueRange;
        NSMutableAttributedString *attributedString = [self attributedStringFromValue:value];
        
        CGFloat rightSliderCenter = [_priceSlider rightSliderCenter];
        [_rightPriceLabel setFrame:(CGRect){_priceSlider.bounds.origin.x + rightSliderCenter, _priceSlider.frame.origin.y + CGRectGetHeight(_priceSlider.bounds) + 10, attributedString.size}];
        [_rightPriceLabel setCenter:CGPointMake(rightSliderCenter + CGRectGetHeight(_priceSlider.bounds) / 2, _rightPriceLabel.center.y)];
        [_rightPriceLabel setAttributedText:attributedString];
    }
}

- (NSMutableAttributedString *)attributedStringFromValue:(int)value {
    NSString *price = [NSString stringWithFormat:@"%@%d", @"￥", value];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFontSize] range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:priceFontSize] range:NSMakeRange(1, attributedString.length - 1)];
    
    return attributedString;
}

@end
