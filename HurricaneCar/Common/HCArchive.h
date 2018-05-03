//
//  HCArchive.h
//  HurricaneCar
//
//  Created by Country on 2018/4/21.
//  Copyright © 2018年 Future9988x. All rights reserved.
//
/**
 * 归档相关类
 */
#import <Foundation/Foundation.h>

@interface HCArchive : NSObject
/** 缓存、获取帐号密码信息 */
+ (void)saveAccount:(NSDictionary *)dict;
+ (NSDictionary *)unAccount;

/** 缓存、获取登录状态 **/
+(void)saveLoginStatus:(BOOL)login;
+(BOOL)unLoginStatus;


@end
