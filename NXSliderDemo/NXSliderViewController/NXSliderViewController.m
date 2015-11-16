//
//  NXSliderViewController.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/20.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "NXSliderViewController.h"
#import "ViewController.h"
#import "MenuViewController.h"

static CGFloat FullDistanceProportion = 0.78; //右侧主视图左边界距离屏幕左边界的距离占屏幕宽度的比例
static CGFloat Proportion = 0.77; //右侧主视图的高度占屏幕高度的比例
static CGFloat ProportionOfLeftView = 1;
static CGFloat ProportionOfLeftViewBeginning = 0.8;
static CGFloat DistanceOfLeftView = 50;

@interface NXSliderViewController ()

@property (nonatomic) CGPoint centerOfLeftViewAtBeginning;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) MenuViewController *leftViewController;
@property (nonatomic, strong) Room107ViewController *centerViewController;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *blackCover;
@property (nonatomic) CGFloat distance;

@end

@implementation NXSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 给主视图设置背景
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [imageView setImage:[UIImage imageNamed:@"back"]];
//    [self.view addSubview:imageView];
    [self.view setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
    
//    if ([self mainScreenSize].width > 320) {
//        ProportionOfLeftView = [self mainScreenSize].width / 320;
//        DistanceOfLeftView += ([self mainScreenSize].width - 320) * FullDistanceProportion / 2;
//    }
    ProportionOfLeftView = 1;
    DistanceOfLeftView += 0;
    
    _leftViewController = [[MenuViewController alloc] init];
    _leftViewController.view.center = CGPointMake(_leftViewController.view.center.x - DistanceOfLeftView, _leftViewController.view.center.y);
    _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, ProportionOfLeftViewBeginning, ProportionOfLeftViewBeginning);
    _centerOfLeftViewAtBeginning = _leftViewController.view.center;
    [self.view addSubview:_leftViewController.view];
    
    // 增加黑色遮罩层，实现视差特效
    _blackCover = [[UIView alloc] initWithFrame:self.view.frame];
    [_blackCover setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_blackCover];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sideslipCenterViewControllerDidChange:) name:SideslipCenterViewControllerDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftView) name:SideslipShowLeftViewNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCenterView) name:SideslipShowCenterViewNotification object:nil];
    
    [self resetCenterViewController:[[ViewController alloc] init]];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCenterView)];
}

- (CGFloat)heightOfNavigationBar {
    return 44.0f;
}

- (void)sideslipCenterViewControllerDidChange:(NSNotification *)notification {
    [self resetCenterViewController:(Room107ViewController *)[notification object]];
}

- (void)resetCenterViewController:(Room107ViewController *)viewController {
    _centerViewController = viewController;
    [_centerViewController setHeaderType:HeaderTypeWhiteMenu];
    if (!_homeNavigationController) {
        _homeNavigationController = [[UINavigationController alloc] init];
        //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [_homeNavigationController.navigationBar setBarTintColor:[UIColor room107GreenColor]];
        _homeNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont room107FontFour]};//控制标题的样式
        [_homeNavigationController.navigationBar setTintColor:[UIColor whiteColor]];//控制返回按钮的样式
        [_homeNavigationController.navigationBar setTranslucent:NO];
//        [_homeNavigationController setViewControllers:@[_centerViewController]];
//        NSLog(@"_homeNavigationController.viewControllers:%@", _homeNavigationController.viewControllers);
        _leftViewController.navigationController = _homeNavigationController;
    }
    if (_centerView) {
        [_centerView removeFromSuperview];
    }
    [_homeNavigationController setViewControllers:@[_centerViewController]];
    _centerView = _homeNavigationController.view;
    [self.view addSubview:_centerView];

    [self showCenterView];
    
    UIPanGestureRecognizer *viewPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewMoved:)];
    [_centerView addGestureRecognizer:viewPanGesture];
}

- (CGSize)mainScreenSize {
    return [[UIScreen mainScreen] bounds].size;
}

// 响应 UIPanGestureRecognizer 事件
- (void)viewMoved:(UIPanGestureRecognizer *)rec {
    CGFloat X = [rec translationInView:self.view].x;
    CGFloat trueDistance = _distance + X; // 实时距离
    CGFloat trueProportion = trueDistance / ([self mainScreenSize].width * FullDistanceProportion);
//    NSLog(@"X:%f, trueProportion:%f", X, trueProportion);
    
    if (rec.state == UIGestureRecognizerStateBegan) {
        if (trueProportion >= 0) {
            _centerView.layer.cornerRadius = 10.0f;
        }
    } else if (rec.state == UIGestureRecognizerStateChanged) {
    } else if (rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateCancelled || rec.state == UIGestureRecognizerStateFailed) {
        // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
        if (trueDistance > [self mainScreenSize].width * (Proportion / 3)) {
            [self showLeftView];
        } else if (trueDistance < [self mainScreenSize].width * -(Proportion / 3)){
            [self showRightView];
        } else {
            [self showCenterView];
        }
        
        return;
    }
    
    if (trueProportion < 0) {
        //取消左滑动画
        return;
    }
    
    // 计算缩放比例
    CGFloat proportion = rec.view.bounds.origin.x >= 0 ? -1 : 1;
    proportion *= trueDistance / [self mainScreenSize].width;
    proportion *= (1 - Proportion);
    proportion /= (FullDistanceProportion + Proportion / 2 - 0.5);
    proportion += 1;
    if (proportion <= Proportion) {
        // 若比例已经达到最小，则不再继续动画
        return;
    }
    // 执行视差特效
    _blackCover.alpha = (proportion - Proportion) / (1 - Proportion);
    // 执行平移和缩放动画
    rec.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    // 执行左视图动画
    CGFloat pro = 0.8 + (ProportionOfLeftView - 0.8) * trueProportion;
    _leftViewController.view.center = CGPointMake(_centerOfLeftViewAtBeginning.x + DistanceOfLeftView * trueProportion, _centerOfLeftViewAtBeginning.y - (ProportionOfLeftView - 1) * _leftViewController.view.frame.size.height * trueProportion / 2);
    _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
}

// 展示左视图
- (void)showLeftView {
    [_centerView addGestureRecognizer:_tapGesture];
    _distance = self.view.center.x * (FullDistanceProportion * 2 + Proportion - 1);
    [self doTheAnimateWithProportion:Proportion andShowWhat:@"left"];
}

// 展示中间视图
- (void)showCenterView {
    [_centerView removeGestureRecognizer:_tapGesture];
    _distance = 0;
    [self doTheAnimateWithProportion:1 andShowWhat:@"center"];
}

// 展示右视图
- (void)showRightView {
    [_centerView addGestureRecognizer:_tapGesture];
    _distance = self.view.center.x * -(FullDistanceProportion * 2 + Proportion - 1);
    [self doTheAnimateWithProportion:Proportion andShowWhat:@"right"];
}

- (void)doTheAnimateWithProportion:(CGFloat)proportion andShowWhat:(NSString *)viewName {
    _centerView.layer.cornerRadius = 10.0f;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerView.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        _centerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        if ([viewName isEqualToString:@"left"]) {
            _leftViewController.view.center = CGPointMake(_centerOfLeftViewAtBeginning.x + DistanceOfLeftView, _leftViewController.view.center.y);
            _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, ProportionOfLeftView, ProportionOfLeftView);
        } else {
            _leftViewController.view.center = _centerOfLeftViewAtBeginning;
            _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, ProportionOfLeftViewBeginning, ProportionOfLeftViewBeginning);
        }
        _blackCover.alpha = [viewName isEqualToString:@"center"] ? 1 : 0;
        self.leftViewController.view.alpha = [viewName isEqualToString:@"right"] ? 0 : 1;
    } completion:^(BOOL finished) {
        if ([viewName isEqualToString:@"center"]) {
            _centerView.layer.cornerRadius = 0.0f;
        }
    }];
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
