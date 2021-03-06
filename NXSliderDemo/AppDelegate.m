//
//  AppDelegate.m
//  NXSliderDemo
//
//  Created by ningxia on 15/7/16.
//  Copyright (c) 2015年 NingXia. All rights reserved.
//

#import "AppDelegate.h"
//#import "NXSliderViewController.h"
#import "UITabBar+Badge.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray *viewControllerConfigs;

@end

@implementation AppDelegate

- (UIViewController *)mainViewController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.delegate = self;
    tabBarController.tabBar.barTintColor = [UIColor whiteColor]; //背景色
    tabBarController.tabBar.tintColor = [UIColor room107GreenColor]; //选中色
    
    _viewControllerConfigs = @[@{@"identifier":@"ViewController", @"title":@"个人", @"image":@"\ue64d", @"badgeValue":@"123"}, @{@"identifier":@"SuiteSearchViewController", @"title":@"找房", @"image":@"\ue61a", @"badgeValue":@"1"}, @{@"identifier":@"PostSuiteManageViewController", @"title":@"出租", @"image":@"\ue64c", @"badgeValue":@""}];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSDictionary *config in _viewControllerConfigs) {
        UIViewController *viewController = [[NSClassFromString(config[@"identifier"]) alloc] init];
        
        //每个ChildViewController增加一个UINavigationController
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationController.navigationBar setBarTintColor:[UIColor room107GreenColor]];
        navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont room107FontFour]};//控制标题的样式
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];//控制返回按钮的样式
        [navigationController.navigationBar setTranslucent:NO];
        //取消navigationBar底部阴影线
        //    [homeNavigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        [navigationController.navigationBar setShadowImage:[UIImage new]];

        [viewControllers addObject:navigationController];
    }
    tabBarController.viewControllers = viewControllers;
    
    [tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *tabBarItem, NSUInteger index, BOOL *stop) {
        NSDictionary *config = [_viewControllerConfigs objectAtIndex:index];
        tabBarItem.title = config[@"title"];
        tabBarItem.image = [UIImage makeImageFromText:config[@"image"] font:[UIFont room107FontFive] color:[UIColor room107GrayColorC]];
        tabBarItem.selectedImage = [UIImage makeImageFromText:config[@"image"] font:[UIFont room107FontFive] color:[UIColor room107GreenColor]];
//        tabBarItem.badgeValue = config[@"badgeValue"];
        //显示
        [tabBarController.tabBar showBadgeOnItemIndex:index];
        //隐藏
//        [tabBarController.tabBar hideBadgeOnItemIndex:index];
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    }];
//    tabBarViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    //动态改变Frame
//    CGRect frame = CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]) - navigationBarHeight, CGRectGetWidth([[UIScreen mainScreen] bounds]), navigationBarHeight);
//    tabBarViewController.tabBar.frame = frame;
    
    return tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //设置控制器为Window的根控制器
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[self mainViewController]];
    self.window.rootViewController = [self mainViewController];
    //    self.window.rootViewController = [[NXSliderViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // 改变 StatusBar 颜色
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

//#pragma mark - UITabBarControllerDelegate
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    [tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *tabBarItem, NSUInteger idx, BOOL *stop) {
//        NSDictionary *config = [_viewControllerConfigs objectAtIndex:idx];
//        tabBarItem.title = config[@"title"];
//    }];
//}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "NingXia.NXSliderDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NXSliderDemo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NXSliderDemo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
