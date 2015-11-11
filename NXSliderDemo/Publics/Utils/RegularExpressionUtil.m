//
//  RegularExpressionUtil.m
//  room107
//
//  Created by ningxia on 15/7/14.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import "RegularExpressionUtil.h"

@implementation RegularExpressionUtil

+ (BOOL)validNumber:(NSString *)number {
    NSString *regularExpression = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [numberPre evaluateWithObject:number];
}

+ (BOOL)validPhoneNumber:(NSString *)number {
    if (number.length != 11) {
        return NO;
    }
    
    NSString *regularExpression = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [numberPre evaluateWithObject:number];
}

+ (BOOL)validPassword:(NSString *)password {
    if ((password.length < 5) || (password.length > 30)) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)validEmail:(NSString *)email {
//    NSString *regularExpression = @"/^w+((-w+)|(.w+))*@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$/)";
    NSString *regularExpression = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression];
    return [emailPre evaluateWithObject:email];
}

@end
