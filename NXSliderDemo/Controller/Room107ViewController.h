//
//  Room107ViewController.h
//  room107
//
//  Created by ningxia on 15/8/26.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HeaderTypeNone = 2000, //无任何样式
    HeaderTypeGreenBack, //按钮为返回（绿色）
    HeaderTypeWhiteBack, //按钮为返回（白色）
    HeaderTypeWhiteMenu, //按钮为菜单（白色）
} HeaderType;

@interface Room107ViewController : UIViewController

@property (nonatomic) BOOL isVisible;

- (void)setHeaderType:(HeaderType)type;
- (HeaderType)headerType;
- (CGFloat)originX;
- (CGFloat)spacingY;
- (CGFloat)heightOfNavigationBar;
- (CGFloat)heightOfSegmentedControl;
- (CGFloat)heightOfTradingProcessView;
- (void)setRightBarButtonTitle:(NSString *)title;
- (void)showLoginOrRegisterViewController;
- (void)showAuthenticateViewController;
- (BOOL)presentViewController:(UIViewController *)viewControllerToPresent;
- (UILabel *)showContent:(NSString *)content withFrame:(CGRect)frame;
- (void)showLoadingView;
- (void)hideLoadingView;
- (CGFloat)menuWidth;
- (CGFloat)menuOriginX;
- (void)showOrHideMenu;
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;

@end
