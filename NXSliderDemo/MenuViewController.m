//
//  MenuViewController.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/20.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
#import "SuiteSearchViewController.h"
#import "InterestSuiteViewController.h"
#import "RentalManageViewController.h"
#import "PostSuiteViewController.h"
#import "PostSuiteManageViewController.h"
#import "CustomButton.h"
#import "MessageListViewController.h"
#import "SuggestionViewController.h"
#import "AboutViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *memuArray;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    NSMutableDictionary *personalDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"个人", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"主页"}, nil], @"values", nil];
    NSMutableDictionary *renterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"租客", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"我的找房"}, @{@"icon":@"1", @"name":@"目标房间"}, @{@"icon":@"1", @"name":@"租住管理"}, nil], @"values", nil];
    NSMutableDictionary *landlordDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"房东", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"发房页"}, @{@"icon":@"1", @"name":@"发房管理"}, nil], @"values", nil];
    _memuArray = [[NSMutableArray alloc] initWithObjects:personalDictionary, renterDictionary, landlordDictionary, nil];
    
    _menuTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [_menuTableView setBackgroundColor:[UIColor clearColor]];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 40.0f}];
    _menuTableView.tableFooterView = [self createTableFooterView];
    [self.view addSubview:_menuTableView];
}

- (UIView *)createTableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:(CGRect){0, CGRectGetHeight(self.view.bounds) - 80.0f, CGRectGetWidth(self.view.bounds), 80.0f}];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat originX = 22.0f;
    CGFloat buttonHeight = 40.0f;
    CGFloat buttonWidth = 60.0f;
    CGFloat spaceX = 20.0f;
    CGFloat originY = CGRectGetHeight(footerView.bounds) - buttonHeight - 20.0f;
    CustomButton *messageButton = [[CustomButton alloc] initWithFrame:(CGRect){originX, originY, buttonWidth, buttonHeight}];
    [messageButton setBackgroundColor:[UIColor clearColor]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[@"\ue61f" stringByAppendingFormat:@" %@", lang(@"Message")]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor room107GrayColorD] range:NSMakeRange(0, @"\ue61f".length)];
    [messageButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor room107GrayColorD] forState:UIControlStateNormal];
    [messageButton.titleLabel setFont:[UIFont room107FontTwo]];
    [messageButton addTarget:self action:@selector(messageButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:messageButton];
    
    originX += buttonWidth + spaceX;
    CustomButton *suggestionButton = [[CustomButton alloc] initWithFrame:(CGRect){originX, originY, buttonWidth, buttonHeight}];
    [suggestionButton setBackgroundColor:[UIColor clearColor]];
    attributedString = [[NSMutableAttributedString alloc] initWithString:[@"\ue620" stringByAppendingFormat:@" %@", lang(@"Suggestion")]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor room107GrayColorD] range:NSMakeRange(0, @"\ue620".length)];
    [suggestionButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [suggestionButton setTitleColor:[UIColor room107GrayColorD] forState:UIControlStateNormal];
    [suggestionButton.titleLabel setFont:[UIFont room107FontTwo]];
    [suggestionButton addTarget:self action:@selector(suggestionButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:suggestionButton];
    
    originX += buttonWidth + spaceX;
    CustomButton *aboutButton = [[CustomButton alloc] initWithFrame:(CGRect){originX, originY, buttonWidth, buttonHeight}];
    [aboutButton setBackgroundColor:[UIColor clearColor]];
    attributedString = [[NSMutableAttributedString alloc] initWithString:[@"\ue63d" stringByAppendingFormat:@" %@", lang(@"About")]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor room107GrayColorD] range:NSMakeRange(0, @"\ue63d".length)];
    [aboutButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [aboutButton setTitleColor:[UIColor room107GrayColorD] forState:UIControlStateNormal];
    [aboutButton.titleLabel setFont:[UIFont room107FontTwo]];
    [aboutButton addTarget:self action:@selector(aboutButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:aboutButton];
    
    return footerView;
}

- (IBAction)messageButtonDidClick:(id)sender {
    MessageListViewController *messageListViewController = [[MessageListViewController alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:messageListViewController];
    //    [messageListViewController setHeaderType:HeaderTypeGreenAndBack];
    //    [self presentViewController:messageListViewController animated:YES completion:^{
    //    }];
}

- (IBAction)suggestionButtonDidClick:(id)sender {
    SuggestionViewController *suggestionViewController = [[SuggestionViewController alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:suggestionViewController];
    //    [suggestionViewController setHeaderType:HeaderTypeGreenAndBack];
    //    [self presentViewController:suggestionViewController animated:YES completion:^{
    //
    //    }];
}

- (IBAction)aboutButtonDidClick:(id)sender {
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:aboutViewController];
    //    [aboutViewController setHeaderType:HeaderTypeGreenAndBack];
    //    [self presentViewController:aboutViewController animated:YES completion:^{
    //        
    //    }];
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
    return 50.0f;
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
            [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:viewController];
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    SuiteSearchViewController *suiteSearchViewController = [[SuiteSearchViewController alloc] init];
                    [suiteSearchViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:suiteSearchViewController];
                }
                    break;
                case 1:
                {
                    InterestSuiteViewController *interestSuiteViewController = [[InterestSuiteViewController alloc] init];
                    [interestSuiteViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:interestSuiteViewController];
                }
                    break;
                case 2:
                {
                    RentalManageViewController *rentalManageViewController = [[RentalManageViewController alloc] init];
                    [rentalManageViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:rentalManageViewController];
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
                    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:postSuiteViewController];
                }
                    break;
                case 1:
                {
                    PostSuiteManageViewController *postSuiteManageViewController = [[PostSuiteManageViewController alloc] init];
                    [postSuiteManageViewController setTitle:_memuArray[indexPath.section][@"values"][indexPath.row][@"name"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:SideslipCenterViewControllerDidChangeNotification object:postSuiteManageViewController];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
