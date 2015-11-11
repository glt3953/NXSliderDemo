//
//  NXURLHandler.m
//  room107
//
//  Created by ningxia on 15/9/9.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "NXURLHandler.h"
//#import "SuiteViewController.h"
//#import "SuiteSearchResultViewController.h"
#import "NSString+Encoded.h"

@implementation NXURLHandler

+ (NXURLHandler *)sharedInstance {
    static NXURLHandler *sharedInstace = nil;
    
    if (sharedInstace == nil) {
        sharedInstace = [[NXURLHandler alloc] init];
    }
    
    return sharedInstace;
}

- (BOOL)handleOpenURL:(NSURL *)url params:(NSDictionary *)params context:(id)context {
    if ([[url scheme] isEqualToString:@"room107"]) {
        NSString *module = [url host];
        NSString *function = [[url path] substringFromIndex:0];
        NSDictionary *arguments = [self argumentsFromQueryString:[url query]];
        LogDebug(@"handleOpenURL:context: - module:%@, function:%@, params:%@, arguments:%@", module, function, params, arguments);
        
        if ([module isEqualToString:@"call"]) {
            //识别room107://call?uri=tel%3A52882522类型的H5中拨打电话的功能
            NSString *title = [[arguments[@"uri"] URLDecodedString] substringFromIndex:@"tel:".length];
            NSString *message = @"";
            NSString *cancelButtonTitle = lang(@"Cancel");
            NSString *otherTitle = lang(@"Dial");
            
            return NO;
        }
        
        Room107ViewController *viewController = (Room107ViewController *)[self viewControllerFromModule:module];
        if (viewController != nil) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:params];
            if ([url fragment]) {
                [dic setValue:[url fragment] forKey:@"fragment"];
            }
            if ([module isEqualToString:@"html"] && arguments) {
                //增加从h5里面的链接点出去的跳转逻辑
                if (arguments[@"title"]) {
                    [dic setValue:arguments[@"title"] forKey:@"title"];
                }
                if (arguments[@"url"]) {
                    [dic setValue:arguments[@"url"] forKey:@"url"];
                }
            }
            [viewController setValue:dic forKey:@"URLParams"];
            //                [[App visibleViewController].navigationController pushViewController:viewController animated:YES];

//            if ([viewController isKindOfClass:[SuiteViewController class]]) {
//                [viewController setHeaderType:HeaderTypeOnlyBack];
//            } else {
//                if ([viewController isKindOfClass:[SuiteSearchResultViewController class]]) {
//                    [viewController setValue:@{@"prevViewController":context} forKey:@"URLParams"];
//                } else {
//                    [viewController setHeaderType:HeaderTypeGreenAndBack];
//                }
//            }
            [context presentViewController:viewController];
        }
            
        return NO;
    }
        
    return YES;
}

//- (BOOL)handleOpenURL:(NSURL *)url context:(id)context {
//    if ([[url scheme] isEqualToString:@"room107"]) {
//        NSString *module = [url host];
//        NSString *function = [[url path] substringFromIndex:0];
//        NSDictionary *arguments = [self argumentsFromQueryString:[url query]];
//        LogDebug(@"handleOpenURL:context: - module:%@, function:%@, arguments:%@", module, function, arguments);
//        
//        if ([function isEqualToString:@"view"]) {
//            UIViewController *viewController = [self viewControllerFromModule:module];
//            if (viewController != nil) {
//                [viewController setValue:arguments forKey:@"URLArguments"];
//                [[App visibleViewController].navigationController pushViewController:viewController animated:YES];
//            }
//        } else if ([function isEqualToString:@"modify"]) {
//            SEL actionSelector = NSSelectorFromString([NSString stringWithFormat:@"modify%@:", [module stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[module  substringToIndex:1] capitalizedString]]]);
//            NSAssert(context != nil, @"%@ field should not with a nil context!", function);
//            
//            if ([context respondsToSelector:actionSelector]) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//                [context performSelector:actionSelector withObject:arguments];
//#pragma clang diagnostic pop
//            }
//        }
//        return NO;
//    }
//    return YES;
//}

- (NSDictionary *)argumentsFromQueryString:(NSString *)query {
    NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
    {
        for (NSString *param in [query componentsSeparatedByString:@"&"]) {
            NSArray *kv = [param componentsSeparatedByString:@"="];
            if ([kv count] > 1) {
                [arguments setObject:kv[1] forKey:kv[0]];
            }
        }
    }
    return arguments;
}

- (UIViewController *)viewControllerFromModule:(NSString *)name {
    static NSDictionary *moduleViewControllerMap = nil;
    if (moduleViewControllerMap == nil) {
        moduleViewControllerMap = @{
                                    @"userLogin":@"LoginOrRegisterViewController", //登录页
                                    @"userResetPassword":@"LoginOrRegisterViewController", //重置密码页（进入后自动发送验证码）
                                    @"userVerify":@"AuthenticateViewController", //认证页
                                    
                                    @"accountInfo":@"UserCenterViewController", //用户中心页
                                    @"accountBalance":@"BalanceViewController", //余额页
                                    @"accountWithdrawal":@"WithdrawViewController", //提现页
                                    @"accountCoupon":@"RedBagViewController", //红包页
                                    @"accountHistory":@"HistoryBalanceViewController", //历史账单页
                                    
                                    @"houseSearch":@"SuiteSearchViewController", //房子搜索页
                                    @"houseGetSubscribes":@"SuiteSearchResultViewController", //房子列表页
                                    @"houseDetail":@"SuiteViewController", //房子详情页
                                    @"houseGetInterest":@"InterestSuiteViewController", //目标房源页
                                    @"contractTenantStatus":@"TenantTradingViewController", //租客合同填写页
                                    @"houseTenantList":@"RentalManageViewController", //租客租住管理列表页
                                    @"houseTenantManage":@"TenantContractManageViewController", //租客租住管理详情页
                                  @"houseTenantManage#expense":@"TenantContractManageViewController", //租客租住管理详情页
                                   @"houseTenantManage#income":@"TenantContractManageViewController", //租客租住管理详情页
                                    @"houseTenantManage#info":@"TenantContractManageViewController", //租客租住管理详情页
                                    
                                    @"houseManageAdd":@"PostSuiteViewController", //发房页
                                    @"houseManageStatus":@"SuiteManageViewController", //理房页
                                    @"contractLandlordList":@"SignedInviteViewController", //合同请求列表页
                                    @"contractLandlordStatus":@"LandlordTradingViewController", //房东合同填写页
                                    @"houseLandlordList":@"PostSuiteManageViewController", //房东出租管理列表页
                                    @"houseLandlordManage":@"LandlordContractManageViewController", //房东出租管理详情页
                            @"houseLandlordManage#expense":@"LandlordContractManageViewController", //房东租住管理详情页
                            @"houseLandlordManage#income":@"LandlordContractManageViewController", //房东租住管理详情页
                                 @"houseLandlordManage#info":@"LandlordContractManageViewController", //房东租住管理详情页
                                    
                                    @"home":@"HomeViewController", //首页
                                    @"feedback":@"SuggestionViewController", //反馈页
                                    @"messageList":@"MessageListViewController", //消息列表页
                                    @"messageDetail":@"MessageDetailViewController", //消息详情页
                                    
                                    @"html":@"NXWebViewController" //html页面
                                    };
    }
    return [[NSClassFromString(moduleViewControllerMap[name]) alloc] init] ;
}

@end
