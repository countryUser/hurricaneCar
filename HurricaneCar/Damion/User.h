//
//  User.h
//  HurricaneCar
//
//  Created by Country on 2018/4/19.
//  Copyright © 2018年 Future9988x. All rights reserved.
//
/**
 * 用户
 */
#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic, assign) NSInteger userid;
@property(nonatomic, strong) NSString *userName;

@property(nonatomic, assign) BOOL isAuthentication; //是否认证，YES-已认证，NO-未认证

@end
