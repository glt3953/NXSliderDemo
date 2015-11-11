//
//  AssetsPickerViewController.h
//  room107
//
//  Created by ningxia on 15/7/23.
//  Copyright (c) 2015年 107room. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol AssetsPickerControllerDelegate;

/// A controller that allows picking multiple photos and videos from user's photo library.
@interface AssetsPickerController : UINavigationController

/// The assets picker’s delegate object.
@property (nonatomic, weak) id <UINavigationControllerDelegate, AssetsPickerControllerDelegate> delegate;

/// Set the ALAssetsFilter to filter the picker contents.
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

/// The maximum number of assets to be picked.
@property (nonatomic, assign) NSInteger maximumNumberOfSelection;

/**
 Determines whether or not the cancel button is visible in the picker
 @discussion The cancel button is visible by default. To hide the cancel button, (e.g. presenting the picker in UIPopoverController)
 set this property’s value to NO.
 */
@property (nonatomic, assign) BOOL showsCancelButton;

@end


/**
 The CTAssetsPickerControllerDelegate protocol defines methods that your delegate object must implement to interact with the assets picker interface. The methods of this protocol notify your delegate when the user finish picking photos or videos, or cancels the picker operation.
 */
@protocol AssetsPickerControllerDelegate <NSObject>

/**
 Tells the delegate that the user finish picking photos or videos.
 @param picker The controller object managing the assets picker interface.
 @param assets An array containing picked ALAsset objects
 */
- (void)assetsPickerController:(AssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

/**
 Tells the delegate that the user cancelled the pick operation.
 @param picker The controller object managing the assets picker interface.
 */
- (void)assetsPickerControllerDidCancel:(AssetsPickerController *)picker;

@end
