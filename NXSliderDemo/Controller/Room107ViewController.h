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
- (void)viewTenantExplanation; //租客说明
- (void)viewLandlordExplanation; //出租说明
- (void)viewPricingRules; //定价规则
- (void)viewContractBycontractID:(NSNumber *)contractID; //查看合同
- (void)sendContractBycontractID:(NSNumber *)contractID; //邮寄合同
- (void)viewHistoryPayment; //历史账单
- (void)viewRepairExplanation; //维修申请
- (void)viewAppealsBreach; //违约申诉
- (void)viewSignExplanation; //签约说明
- (void)viewProtocalExplanation; //用户协议
- (void)viewMonthlyPaymentExplanation; //月付协议
- (void)viewWalletExplanation; //钱包说明
- (void)viewPaymentExplanation; //支付说明

@end
