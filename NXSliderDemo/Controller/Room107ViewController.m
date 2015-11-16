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
#import "SCGIFImageView.h"
//#import "HistoryBalanceViewController.h"
#import "Room107GradientLayer.h"
//#import "NSNumber+Additions.h"
//#import "SystemAgent.h"
//#import "MessageDetailViewController.h"
//#import "Room107UserDefaults.h"
//#import "SendPaperContractViewController.h"

@interface Room107ViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *leftButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
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

    _leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage makeImageFromText:@"\ue60c" font:[UIFont room107FontFour] color:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidClick:)];
    switch (_headerType) {
        case HeaderTypeNone:
            break;
        case HeaderTypeGreenBack:
            [_leftButtonItem setImage:[UIImage makeImageFromText:@"\ue60c" font:[UIFont room107FontFour] color:[UIColor room107GreenColor]]];
            break;
        case HeaderTypeWhiteBack:
            [_leftButtonItem setImage:[UIImage makeImageFromText:@"\ue60c" font:[UIFont room107FontFour] color:[UIColor whiteColor]]];
            break;
        case HeaderTypeWhiteMenu:
            [_leftButtonItem setImage:[UIImage makeImageFromText:@"\ue611" font:[UIFont room107FontFour] color:[UIColor whiteColor]]];
//            _leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage makeImageFromText:@"\ue611" font:[UIFont room107FontFour] color:[UIColor whiteColor]] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonDidClick:)];
//            self.navigationItem.leftBarButtonItem = _leftButtonItem;
            break;
        default:
            break;
    }
    self.navigationItem.leftBarButtonItem = _leftButtonItem;
    // 弥补因为返回按钮被替换导致的边缘滑入手势失效的问题
    UIPanGestureRecognizer *viewPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarButtonDidClick:)];
    [self.view addGestureRecognizer:viewPanGesture];

    _rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDidClick:)];
    _rightButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)setHeaderType:(HeaderType)type {
    _headerType = type;
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


- (IBAction)leftBarButtonDidClick:(id)sender {
    if (_headerType == HeaderTypeWhiteMenu) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SideslipShowLeftViewNotification object:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)rightBarButtonDidClick:(id)sender {
    
}

- (void)setRightBarButtonTitle:(NSString *)title {
    _rightButtonItem.enabled = YES;
    if (title.length == 1) {
        [_rightButtonItem setImage:[UIImage makeImageFromText:@"\ue642" font:[UIFont room107FontThree] color:[UIColor whiteColor]]];
    } else {
        [_rightButtonItem setTitle:title];
    }
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

- (void)showLoadingView {
    if (!_loadingView) {
        [self createLoadingView];
    }
    
    [[App window] bringSubviewToFront:_loadingView];
    _loadingView.hidden = NO;
    
    //    [self performSelector:@selector(hideLoadingView) withObject:nil afterDelay:5];
    //    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(hideLoadingView) userInfo:nil repeats:NO];
}

- (void)createLoadingView {
    //网络加载Loading
    CGRect frame = [[UIScreen mainScreen] bounds];
    //    frame.origin.y = statusBarHeight + [self heightOfNavigationBar];
    //    frame.size.height -= frame.origin.y;
    _loadingView = [[UIView alloc] initWithFrame:frame];
    Room107GradientLayer *gradientLayer = [[Room107GradientLayer alloc] initWithFrame:[_loadingView bounds] andStartAlpha:0.3f andEndAlpha:0.3f];
    [_loadingView.layer insertSublayer:gradientLayer atIndex:0];
    _loadingView.hidden = YES;
    [[App window] addSubview:_loadingView]; //铺满整个屏幕
    
    CGFloat imageViewWidth = 100;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    SCGIFImageView *loadingImageView = [[SCGIFImageView alloc] initWithFrame:(CGRect){0, 0, imageViewWidth, imageViewWidth}];
    loadingImageView.center = CGPointMake(_loadingView.frame.size.width / 2, _loadingView.frame.size.height / 2);
    [loadingImageView setData:imageData];
    [_loadingView addSubview:loadingImageView];
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
