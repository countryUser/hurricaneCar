//
//  HCArchive.m
//  HurricaneCar
//
//  Created by Country on 2018/4/21.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "HCArchive.h"

// 帐号缓存地址
#define XXACCOUNT [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]
// 登录状态缓存地址
#define XXLOGIN [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"login.archiver"]

@implementation HCArchive

/** 缓存、获取帐号密码信息 */
+ (void)saveAccount:(NSDictionary *)dict{
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"account"]) {
            [NSKeyedArchiver archiveRootObject:dict toFile:XXACCOUNT];
        }
    }];
}
+ (NSDictionary *)unAccount{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:XXACCOUNT];
}

/** 缓存、获取登录状态 **/
+(void)saveLoginStatus:(BOOL)login{
    [NSKeyedArchiver archiveRootObject:@(login) toFile:XXLOGIN];
}
+(BOOL)unLoginStatus{
    return [[NSKeyedUnarchiver unarchiveObjectWithFile:XXLOGIN] boolValue];
}

@end
