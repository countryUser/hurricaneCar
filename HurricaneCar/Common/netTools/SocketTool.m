//
//  SocketTool.m
//  HurricaneCar
//
//  Created by Country on 2018/1/7.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "SocketTool.h"

#import "AFNetworking.h"

static NSString *urlStr_insertUser = @"http://47.100.24.146:8000/userinfo/insertUserInfo"; //新增用户的url
static NSString *uelStr_getUser = @"http://47.100.24.146:8000/userinfo/getUserInfo"; //获取用户信息的url
static NSString *urlStr_updateUser = @"http://47.100.24.146:8000/userinfo/updateUserInfo"; //更新用户的url
static NSString *urlStr_createOrder = @"http://47.100.24.146:8000/orderinfo/createOrder"; //生成订单
static NSString *urlStr_payOrder = @"http://47.100.24.146:8000/payinfo/pay";

@interface SocketTool()
{
    NSString *urlStr_getCar;
}
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SocketTool

-(instancetype)init{
    if (self = [super init]) {
        urlStr_getCar = http(@"carinfo/getCarInfo");
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer]; ////更改响应默认的解析方式为字符串解析
    }
    return self;
}

+(instancetype)singale{
    static SocketTool *socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [[SocketTool alloc] init];
    });
    
    return socket;
}

///登录
-(void)loginUser:(NSString *)name pass:(NSString *)password{
    
}

/// 注册
-(void)registerUser:(NSString *)name pass:(NSString *)password{
    NSLog(@"注册");
    NSDictionary *param = @{@"user_key":name,
                            @"mobile":@"15666698065",
                            @"device_id":[[NSUUID UUID] UUIDString],
                            @"nickname":name,
                            @"password":password,
                            @"code":@"1417",
                            @"avatar":@""};
    [_sessionManager POST:urlStr_insertUser
               parameters:param
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                          options:NSJSONReadingMutableContainers error:nil];
                      
                      if(self.delegate){
                          [self.delegate registerResult:YES withData:dic];
                      }else{
                          NSLog(@"未设置代理，注册网络请求成功");
                      }
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (self.delegate) {
                         [self.delegate registerResult:NO withData:nil];
                     }else{
                         NSLog(@"未设置代理，注册网络请求失败");
                     }
                 }];
}

-(void)getCarListWithDelegate:(id)delegate{
    self.delegate = delegate;
    
    NSDictionary *param = @{};
    [_sessionManager POST:urlStr_getCar
               parameters:param
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                          options:NSJSONReadingMutableContainers error:nil];
                      if(self.delegate && [self.delegate respondsToSelector:@selector(getCarList:withData:)]){
                          [self.delegate getCarList:YES withData:dic];
                      }else{
                          NSLog(@"未设置代理，注册网络请求成功");
                      }
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (self.delegate && [self.delegate respondsToSelector:@selector(getCarList:withData:)]) {
                         [self.delegate getCarList:NO withData:nil];
                     }else{
                         NSLog(@"未设置代理，注册网络请求失败");
                     }
                 }];
}

#pragma mark ----
-(void)createOrderWithDelgete:(id)delegate order:(Order *)order{
    self.delegate = delegate;
    
    NSDictionary *param = @{@"id_owner":@(order.id_owner),
                            @"id_renter":order.id_renter,
                            @"car_id":@(order.car_id),
                            @"start_date":order.start_date,
                            @"end_date":order.end_date,
                            @"order_amount":@(order.order_amount),
                            @"model_type":@"order"
                            };
    [_sessionManager POST:urlStr_createOrder
               parameters:param
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                          options:NSJSONReadingMutableContainers error:nil];
                      if (self.delegate && [self.delegate respondsToSelector:@selector(createOrderSuccess:withData:)]) {
                          [self.delegate createOrderSuccess:YES withData:dic];
                      }
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (self.delegate && [self.delegate respondsToSelector:@selector(createOrderSuccess:withData:)]) {
                          [self.delegate createOrderSuccess:NO withData:nil];
                      }
                  }];
}

@end
