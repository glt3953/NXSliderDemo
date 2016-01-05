//
//  CommonFuncs.h
//  room107
//
//  Created by ningxia on 15/6/18.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *imageView2Thumbnails = @"?imageView2/0/h/";
static NSString *imageMogr2Thumbnails = @"?imageMogr2/thumbnail/";
static const CGFloat statusBarHeight = 20.0f;
static const CGFloat navigationBarHeight = 44.0f;
static const CGFloat tabBarHeight = 49;
static NSString *fontIconName = @"107RoomIcon";
static NSString *dateFormatForJSON = @"yyyyMMdd";
static NSString *htmlURI = @"room107://html";
static NSUInteger maxUInteger = 2147483647;
static double maxPaymentCost = 5000 * 100; //支付金额峰值，单位：分

typedef enum {
    UserIdentityTypeTenant = 0, //租客
    UserIdentityTypeLandlord, //房东
} UserIdentityType;

@interface CommonFuncs : NSObject

//获得设备尺寸的序号
+ (NSInteger)getIndexOfDeviceScreen; //0:3.5，1:4.0，2:4.7，3:5.5
//获得设备型号
+ (NSString *)getCurrentDeviceModel;
+ (CGSize)mainScreenSize;
+ (NSDictionary *)newCoverDic;
+ (int)randomNumber;
+ (void)callTelephone:(NSString *)phoneNumber;
+ (NSNumber *)rentTypeForHouse;
//浮点数转换为百分比
+ (NSString *)percentString:(float)floatValue;
/*!
 * get device ip address
 */
+ (NSString *)deviceIPAdress;

+ (NSString *)iconCodeByHexStr:(NSString *)hexStr;

+ (NSString *)moneyStrByDouble:(double)money;

+ (NSNumber *)rentTypeConvert:(NSUInteger)type;

+ (NSNumber *)requiredGender:(NSUInteger)type;

+ (NSInteger)indexOfRentType:(NSNumber *)type;

+ (NSInteger)indexOfGender:(NSNumber *)gender;

+ (NSString *)requiredGenderText:(NSNumber *)gender;

+ (CGFloat)shadowOpacity;
+ (CGFloat)shadowRadius;
+ (UIColor *)shadowColor;

+ (CGFloat)houseCardHeight;

+ (CGFloat)cornerRadius;

+ (BOOL)arrayHasThisContent:(NSArray *)array andObject:(id)object;

@end

#define IS_BITS_SET(V, B) (((V) & (B)) == (B))
#define CLEAR_BITS(V, B) ((V) &= ~(B))
#define SET_BITS(V, B) ((V) |= (B))

#define LocalizedString(stringkey)  NSLocalizedString(stringkey, nil)
