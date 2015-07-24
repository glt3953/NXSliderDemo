//
//  MenuViewController.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/20.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) NSMutableArray *memuArray;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    NSMutableDictionary *renterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"租客", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"我的找房"}, @{@"icon":@"1", @"name":@"目标房间"}, @{@"icon":@"1", @"name":@"租住管理"}, nil], @"values", nil];
    NSMutableDictionary *landlordDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"房东", @"name", [[NSMutableArray alloc] initWithObjects:@{@"icon":@"1", @"name":@"发房页"}, @{@"icon":@"1", @"name":@"发房管理"}, nil], @"values", nil];
    _memuArray = [[NSMutableArray alloc] initWithObjects:renterDictionary, landlordDictionary, nil];
    
    _menuTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [_menuTableView setBackgroundColor:[UIColor clearColor]];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 40.0f}];
    _menuTableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 40.0f}];
    [self.view addSubview:_menuTableView];
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
