//
//  SocketTool.h
//  HurricaneCar
//
//  Created by Country on 2018/1/7.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

/**
 * 网络请求工具类
 */
#import <Foundation/Foundation.h>

#import "Order.h"

@protocol SocketResultDelegate <NSObject>

@optional
-(void)registerResult:(BOOL)success withData:(NSDictionary *)data;
-(void)getCarList:(BOOL)success withData:(NSDictionary *)data;
-(void)createOrderSuccess:(BOOL)success withData:(NSDictionary *)data;
@end

@interface SocketTool : NSObject

@property(nonatomic, weak) id<SocketResultDelegate> delegate;

+(instancetype)singale;

///登录
-(void)loginUser:(NSString *)name pass:(NSString *)password;

/// 注册
-(void)registerUser:(NSString *)name pass:(NSString *)password;

///获取车列表
-(void)getCarListWithDelegate:(id)delegate;
///下单请求
-(void)createOrderWithDelgete:(id)delegate order:(Order *)order;
///付款
-(void)fukuanWithDelegate:(id)delegate uid:(NSInteger)orderId amount:(double)amount;
@end
