//
//  RegularExpressionUtil.h
//  room107
//
//  Created by ningxia on 15/7/14.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpressionUtil : NSObject

//过滤纯数字
+ (BOOL)validNumber:(NSString *)number;

//验证手机号码
+ (BOOL)validPhoneNumber:(NSString *)number;

//验证密码
+ (BOOL)validPassword:(NSString *)password;

//验证邮箱
+ (BOOL)validEmail:(NSString *)email;

@end
