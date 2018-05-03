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

#import <AlipaySDK/AlipaySDK.h>
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

/// NOTE： 9.0之前使用的API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if([url.host isEqualToString:@"safepay"]){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@", resultDic);
        }];
    }
    return YES;
}
@end
