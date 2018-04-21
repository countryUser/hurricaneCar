//
//  AppDelegate.m
//  HurricaneCar
//
//  Created by Country on 2017/12/19.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "ChoiceViewController.h"
#import "OrderViewController.h"
#import "CollectViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:ScreenBound];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    self.window.rootViewController = loginVC;
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    

    ChoiceViewController *choice = [[ChoiceViewController alloc] initWithNibName:@"ChoiceViewController" bundle:nil];
    choice.title = @"选车";
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:choice];
    
    OrderViewController *order = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    order.title = @"订单";
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:order];
    
    CollectViewController *collect = [[CollectViewController alloc] initWithNibName:@"CollectViewController" bundle:nil];
    collect.title = @"车库";
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:collect];
    
    MineViewController *mine = [[MineViewController alloc] initWithNibName:@"MineViewController" bundle:nil];
    mine.title = @"我的";
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:mine];
    [tab setViewControllers:@[nav1, nav2, nav3, nav4]];
    
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
