//
//  ViewController.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/16.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "ViewController.h"
#import "NXRangeSlider.h"

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
    
    CGFloat originX = 20.0f;
    CGFloat originY = 80.0f;
    CGFloat sliderHeight = 50.0f;
    _priceSlider = [[NXRangeSlider alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(self.view.bounds) - 2 * originX, sliderHeight)];
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
    
    originY += sliderHeight;
    originY += 20.0f;
    CGRect frame = self.view.frame;
    frame.origin.y += originY;
    frame.size.height -= originY;
    //使用UIDataDetectorTypes自动检测电话、网址和邮箱
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    [textView setBackgroundColor:[UIColor clearColor]];
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    textView.font = [UIFont systemFontOfSize:20];
    textView.editable = NO;
    textView.text = @"\r\n用户服务专线    010-52882522 (周一至周六：09:30-18:30) \r\n\r\n"
    "公司首页： www.107room.com \r\n\r\n"
    "媒体合作     jinyu@107room.com \r\n\r\n";
//    textView.text = @"北京六度草堂网络科技有限公司
//    简介
//    我们是一家前沿互联网公司，致力于“租房4.0”产品和服务的提供。主要产品「107间」是直接连接租客与房东的真实智能租房平台
//    核心团队为85后，毕业于北京大学、剑桥大学、香港大学等国内外名校，发展至今已拥有十余人的稳定团队
//    Logo·名称·文化
//    logo由斐波那契黄金分割曲线演化而来，从起点经过6个节点不断延伸。代表六度空间理论，即人与人之间的联结性，以及形成关系后的无限可能
//    “六度草堂”中草堂取自杜甫草堂，杜甫的诗句“安得广厦千万间，大庇天下寒士俱欢颜”是我们所追求的理想
//    产品愿景
//    租房1.0——传统中介，利用地面门店获取房源并通过信息垄断牟利
//    租房2.0——分类网站，用互联网提升了部分效率，但信息混乱质量低劣，也没有延伸到线下
//    租房3.0——打着互联网旗号但本质依然通过地面人员联结租房双方的产品，包括传统中介从线下到线上的改变
//    我们的做法：租房4.0——重视信息“真实”与交互“智能”，从线上大量的真实有效信息出发，用移动互联、智能匹配的方式让用户更简单地租房
//    联系方式
//    商务洽谈     weiwei@107room.com          媒体合作     jinyu@107room.com
//    用户服务专线    010-52882522 (周一至周六：09:30-18:30)";
    [self.view addSubview:textView];
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
        [_leftPriceLabel setFrame:(CGRect){_priceSlider.bounds.origin.x + leftSliderCenter, _priceSlider.frame.origin.y - attributedString.size.height - 10, attributedString.size}];
        [_leftPriceLabel setCenter:CGPointMake(leftSliderCenter + CGRectGetHeight(_priceSlider.bounds) / 4, _leftPriceLabel.center.y)];
        [_leftPriceLabel setAttributedText:attributedString];
    }
}

- (void)rightValueDidChange:(NXRangeSlider *)slider {
    if ([slider isEqual:_priceSlider]) {
        int value = _priceSlider.rightValue / _priceSlider.minValueRange;
        value *= _priceSlider.minValueRange;
        NSMutableAttributedString *attributedString = [self attributedStringFromValue:value];
        
        CGFloat rightSliderCenter = [_priceSlider rightSliderCenter];
        [_rightPriceLabel setFrame:(CGRect){_priceSlider.bounds.origin.x + rightSliderCenter, _priceSlider.frame.origin.y - attributedString.size.height - 10, attributedString.size}];
        [_rightPriceLabel setCenter:CGPointMake(rightSliderCenter + CGRectGetHeight(_priceSlider.bounds) / 4, _rightPriceLabel.center.y)];
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
