//
//  Room107ViewController.m
//  room107
//
//  Created by ningxia on 15/8/26.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "Room107ViewController.h"
#import "CustomLabel.h"
#import "CustomButton.h"
#import "GreenTextButton.h"
//#import "LoginOrRegisterViewController.h"
//#import "AuthenticateViewController.h"
#import "SearchTipLabel.h"
//#import "SCGIFImageView.h"
//#import "HistoryBalanceViewController.h"
//#import "Room107GradientLayer.h"
//#import "NSNumber+Additions.h"
//#import "SystemAgent.h"
//#import "MessageDetailViewController.h"
//#import "Room107UserDefaults.h"
//#import "SendPaperContractViewController.h"

@interface Room107ViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CustomButton *leftButton;
@property (nonatomic, strong) CustomLabel *titleLabel;
@property (nonatomic, strong) GreenTextButton *rightButton;
@property (nonatomic) HeaderType headerType;
@property (nonatomic, strong) SearchTipLabel *contentLabel;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) void (^alertCompletionHandler)(void);
@property (nonatomic, strong) UIAlertView *appealsBreachAlertView;
@property (nonatomic, strong) UIAlertView *messageAlertView;
@property (nonatomic, strong) NSDictionary *messageInfo;

@end

@implementation Room107ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor room107ViewBackgroundColor]];
    
    //弹出或取消窗口时异常
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMessageDetail:) name:NewMessageNotification object:nil];
    
    CGFloat originX = 11;
    CGFloat originY = statusBarHeight;
    CGFloat buttonWidth = 22.0f;
    CGFloat labelWidth = CGRectGetWidth(self.view.bounds) - 2 * originX - 2 * buttonWidth;
    
    _headerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, CGRectGetWidth(self.view.bounds), statusBarHeight + [self heightOfNavigationBar]}];
    [_headerView setBackgroundColor:[UIColor room107GreenColor]];
    [self.view addSubview:_headerView];
    _headerView.hidden = YES;
    
    originY += ([self heightOfNavigationBar] - buttonWidth) / 2;
    _leftButton = [[CustomButton alloc] initWithFrame:(CGRect){originX, originY, buttonWidth, buttonWidth}];
    [_leftButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [_leftButton.titleLabel setFont:[UIFont room107FontFour]];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftButton setTitle:@"\ue60c" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftButton];
    _leftButton.hidden = YES;
    
    _titleLabel = [[CustomLabel alloc] initWithFrame:(CGRect){originX + buttonWidth, statusBarHeight, labelWidth, [self heightOfNavigationBar]}];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setFont:[UIFont room107FontFour]];
    [self.view addSubview:_titleLabel];
    _titleLabel.hidden = YES;
    
    _rightButton = [[GreenTextButton alloc] initWithFrame:(CGRect){CGRectGetWidth(self.view.bounds) - originX - 4 * buttonWidth, originY, 4 * buttonWidth, buttonWidth}];
    [_rightButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.view addSubview:_rightButton];
    [_rightButton addTarget:self action:@selector(rightButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.hidden = YES;
    _rightButton.enabled = NO;
    
//    NSArray *appPopups = [[SystemAgent sharedInstance] getPopupPropertiesFromLocal];
//    for (AppPopupModel *appPopup in appPopups) {
//        NSURL *url = [NSURL URLWithString:appPopup.activatedUri];
//        if ([[url scheme] isEqualToString:@"room107"]) {
//            NSString *module = [url host];
//            if ([self isKindOfClass:[[[NXURLHandler sharedInstance] viewControllerFromModule:module] class]]) {
//                id object = [Room107UserDefaults getValueFromUserDefaultsWithKey:NSStringFromClass([self class])];
//                //frequency，频率，必填，0表示首次弹出，1表示每次弹出
//                if ([appPopup.frequency isEqual:@1] || ![object isEqual:@1]) {
//                    [Room107UserDefaults saveUserDefaultsWithKey:NSStringFromClass([self class]) andValue:@1];
//                    [self showAlertViewWithTitle:appPopup.title message:appPopup.popupDescription];
//                }
//                break;
//            }
//        }
//    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _isVisible = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    _isVisible = NO;
}

- (void)showMessageDetail:(NSNotification *)notification {
    if (!_isVisible) {
        return;
    }

    _messageInfo = [notification object][@"message"];
    if ([[notification object][@"applicationState"] integerValue] == UIApplicationStateActive) {
        //程序当前正处于前台
        _messageAlertView = [[UIAlertView alloc] initWithTitle:_messageInfo[@"title"]
                                                                   message:_messageInfo[@"content"]
                                                                  delegate:self
                                                         cancelButtonTitle:lang(@"Cancel")
                                                         otherButtonTitles:[lang(@"ViewSample") substringToIndex:2], nil];
        [_messageAlertView show];
    } else if([[notification object][@"applicationState"] integerValue] == UIApplicationStateInactive || [[notification object][@"applicationState"] integerValue] == UIApplicationStateBackground) {
        //程序处于后台
        [self showMessageDetailViewController];
    }
}

- (void)showMessageDetailViewController {
//    MessageDetailViewController *messageDetailViewController = [[MessageDetailViewController alloc] initWithMessageID:_messageInfo[@"messageId"]];
//    [self presentViewController:messageDetailViewController animated:YES completion:^{
//    }];
}

- (void)setHeaderType:(HeaderType)type {
    [self.view bringSubviewToFront:_headerView];
    [self.view bringSubviewToFront:_leftButton];
    [self.view bringSubviewToFront:_titleLabel];
    [self.view bringSubviewToFront:_rightButton];
    _headerType = type;
    
    switch (type) {
        case HeaderTypeNone:
            _headerView.hidden = YES;
            _leftButton.hidden = NO;
            [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case HeaderTypeOnlyBack:
            _headerView.hidden = YES;
            _leftButton.hidden = NO;
            [_leftButton setTitleColor:[UIColor room107GreenColor] forState:UIControlStateNormal];
            break;
        case HeaderTypeGreenAndBack:
            _headerView.hidden = NO;
            _leftButton.hidden = NO;
            _titleLabel.hidden = NO;
            break;
        case HeaderTypeGreenAndMenu:
            _headerView.hidden = NO;
            _titleLabel.hidden = NO;
            break;
        default:
            break;
    }
}

- (CGFloat)originX {
    return 22;
}

- (CGFloat)spacingY {
    return 8;
}

- (CGFloat)heightOfNavigationBar {
    return navigationBarHeight;
}

- (CGFloat)heightOfSegmentedControl {
    return 40;
}

- (CGFloat)heightOfTradingProcessView {
    return [self heightOfNavigationBar] + [self spacingY] + 2 * [self spacingY];
}

- (void)setTitle:(NSString *)title {
    [_titleLabel setText:title];
}

- (IBAction)leftButtonDidClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)rightButtonDidClick:(id)sender {
    
}

- (void)setRightButtonTitle:(NSString *)title {
    _rightButton.hidden = NO;
    _rightButton.enabled = YES;
    [_rightButton.titleLabel setFont:title.length == 1 ? [UIFont room107FontThree] : [UIFont room107SystemFontThree]];
    [_rightButton setTitle:title forState:UIControlStateNormal];
}


- (BOOL)presentViewController:(UIViewController *)viewControllerToPresent {
    NSArray *viewControllers = @[@"LoginOrRegisterViewController", @"SuiteSearchViewController", @"SuiteSearchResultViewController", @"SuiteViewController", @"HomeViewController", @"SuggestionViewController", @"MessageListViewController", @"MessageDetailViewController", @"NXWebViewController", @"AboutViewController"]; //无登录权限的窗口类
    
    return NO;
//    if (([viewControllers indexOfObject:NSStringFromClass([viewControllerToPresent class])] < maxUInteger) || [[AppClient sharedInstance] isLogin]) {
//        [self presentViewController:viewControllerToPresent animated:YES completion:^{
//        }];
//        
//        return YES;
//    } else {
//       [self showLoginOrRegisterViewController];
//        
//        return NO;
//    }
}

- (UILabel *)showContent:(NSString *)content withFrame:(CGRect)frame {
    if (!_contentLabel) {
        _contentLabel = [[SearchTipLabel alloc] init];
        [_contentLabel setFont:[UIFont room107FontThree]];
        [_contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:_contentLabel];
    }
    [_contentLabel setFrame:frame];
    _contentLabel.hidden = NO;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.alignment = _contentLabel.textAlignment;
    NSDictionary *attributes = @{NSFontAttributeName:_contentLabel.font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:content ? content : @"" attributes:attributes];
    [self.view bringSubviewToFront:_contentLabel];
    
    return _contentLabel;
}

- (void)hideLoadingView {
    _loadingView.hidden = YES;
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:lang(@"OK"), nil];
    [alert show];
}

- (CGFloat)menuWidth {
    return 100;
}

- (CGFloat)menuOriginX {
    return self.view.frame.size.width - 11 - [self menuWidth];
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
