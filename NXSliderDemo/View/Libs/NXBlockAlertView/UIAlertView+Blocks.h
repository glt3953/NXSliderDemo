//
//  UIAlertView+Blocks.h
//  Shibui
//
//  Created by Jiva DeVoe on 12/28/10.
//  Copyright 2010 Random Ideas, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RIButtonItem.h"

/*
使用方法
 NSString *title = NSLocalizedString(@"Alert", nil);
 NSString *message = NSLocalizedString(@"UIAlertView-Blocks", nil);
 NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
 NSString *otherTitle = NSLocalizedString(@"Set", nil);
 
 RIButtonItem *cancelButtonItem = [RIButtonItem itemWithLabel:cancelButtonTitle action:^{
 NSLog(@"Press Button Cancel");
 }];
 
 RIButtonItem *otherButtonItem = [RIButtonItem itemWithLabel:otherTitle action:^{
 NSLog(@"Press Button OK");
 }];
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message cancelButtonItem:nil otherButtonItems:otherButtonItem, nil];
 
 [alert show];
*/

@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(RIButtonItem *)inCancelButtonItem otherButtonItems:(RIButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(RIButtonItem *)item;

@end
