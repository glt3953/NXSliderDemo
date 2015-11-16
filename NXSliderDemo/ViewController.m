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
#import "SuiteSearchViewController.h"
#import "InterestSuiteViewController.h"
#import "RentalManageViewController.h"
#import "PostSuiteViewController.h"
#import "PostSuiteManageViewController.h"

static CGFloat unitFontSize = 10.0f;
static CGFloat priceFontSize = 15.0f;

@interface ViewController () <NXRangeSliderDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *memuArray;
@property (nonatomic,strong) NXRangeSlider *priceSlider;
@property (nonatomic,strong) UILabel *leftPriceLabel;
@property (nonatomic,strong) UILabel *rightPriceLabel;
@property (nonatomic) CGFloat trueDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"主页"];
    
    NSMutableDictionary *personalDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"个人", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"主页"}, nil], @"values", nil];
    NSMutableDictionary *renterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"租客", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"我的找房"}, @{@"icon":@"1", @"name":@"目标房间"}, @{@"icon":@"1", @"name":@"租住管理"}, nil], @"values", nil];
    NSMutableDictionary *landlordDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"房东", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"发房页"}, @{@"icon":@"1", @"name":@"发房管理"}, nil], @"values", nil];
    _memuArray = [[NSMutableArray alloc] initWithObjects:personalDictionary, renterDictionary, landlordDictionary, nil];
    
    _menuTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [_menuTableView setBackgroundColor:[UIColor clearColor]];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.tableFooterView = [self tableFooterView];
    [self.view addSubview:_menuTableView];
}

- (UIView *)tableFooterView {
    UIView * footerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, CGRectGetWidth(self.view.bounds), 200}];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat spaceX = 20;
    _priceSlider = [[NXRangeSlider alloc] initWithFrame:CGRectMake(spaceX, 0, CGRectGetWidth(self.view.bounds) - 2 * spaceX, 50)];
    _priceSlider.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.0f];
    _priceSlider.rangeSliderDelegate = self;
    _priceSlider.minValue = 0;
    _priceSlider.maxValue = 10000;
    _priceSlider.leftValue = 0;
    _priceSlider.rightValue = 10000;
    _priceSlider.minValueRange = 100;
    _priceSlider.shadowRadius = 3.0f;
    [footerView addSubview:_priceSlider];
    
    UIColor *color = [UIColor colorWithRed:50/255.0f green:174/255.0f blue:153/255.0f alpha:1.0f];
    _leftPriceLabel = [[UILabel alloc] init];
    [_leftPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_leftPriceLabel setTextColor:color];
    [footerView addSubview:_leftPriceLabel];
    
    _rightPriceLabel = [[UILabel alloc] init];
    [_rightPriceLabel setBackgroundColor:[UIColor clearColor]];
    [_rightPriceLabel setTextColor:color];
    [footerView addSubview:_rightPriceLabel];
    
    //    self.view.layer.cornerRadius = 10.0f;
    //    self.view.layer.masksToBounds = YES;
    //添加阴影效果
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(-10, 10);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
    self.view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.view.layer.shadowRadius = 10.0f; //阴影半径
    
    CGRect frame = (CGRect){22, 100, 60, 30};
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:@"jump" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    return footerView;
}

- (IBAction)buttonDidClick:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/wei/id414478124"]]; //跳转至App Store
    
//    NSLog(@"self.navigationController:%@", self.navigationController);
    FirstPushViewController *firstPushViewController = [[FirstPushViewController alloc] init];
//    [firstPushViewController setHeaderType:HeaderTypeGreenAndBack];
    [self.navigationController pushViewController:firstPushViewController animated:YES];
    NSLog(@"self.navigationController.viewControllers:%@", self.navigationController.viewControllers);
}

- (IBAction)menuButtonDidClick:(id)sender {
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_memuArray[section][@"values"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    }
    
    [cell.textLabel setText:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _memuArray.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 40.0f}];
    [view setBackgroundColor:[UIColor clearColor]];
    
    CGFloat labelHeight = 30.0f;
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){0, (CGRectGetHeight(view.bounds) - labelHeight) / 2, CGRectGetWidth(view.bounds), labelHeight}];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTextColor:[UIColor blueColor]];
    [label setText:_memuArray[section][@"name"]];
    [view addSubview:label];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            ViewController *viewController = [[ViewController alloc] init];
            [viewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
            [viewController setHeaderType:HeaderTypeWhiteBack];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    SuiteSearchViewController *suiteSearchViewController = [[SuiteSearchViewController alloc] init];
                    [suiteSearchViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [self.navigationController pushViewController:suiteSearchViewController animated:YES];
                }
                    break;
                case 1:
                {
                    InterestSuiteViewController *interestSuiteViewController = [[InterestSuiteViewController alloc] init];
                    [interestSuiteViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [interestSuiteViewController setHeaderType:HeaderTypeWhiteBack];
                    [self.navigationController pushViewController:interestSuiteViewController animated:YES];
                }
                    break;
                case 2:
                {
                    RentalManageViewController *rentalManageViewController = [[RentalManageViewController alloc] init];
                    [rentalManageViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [rentalManageViewController setHeaderType:HeaderTypeWhiteBack];
                    [self.navigationController pushViewController:rentalManageViewController animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    PostSuiteViewController *postSuiteViewController = [[PostSuiteViewController alloc] init];
                    [postSuiteViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [postSuiteViewController setHeaderType:HeaderTypeWhiteBack];
                    [self.navigationController pushViewController:postSuiteViewController animated:YES];
                }
                    break;
                case 1:
                {
                    PostSuiteManageViewController *postSuiteManageViewController = [[PostSuiteManageViewController alloc] init];
                    [postSuiteManageViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [postSuiteManageViewController setHeaderType:HeaderTypeWhiteBack];
                    [self.navigationController pushViewController:postSuiteManageViewController animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

@end
