//
//  Order.h
//  HurricaneCar
//
//  Created by Country on 2018/5/1.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property(nonatomic, assign) NSInteger id_owner;  //车主id
@property(nonatomic, strong) NSString *id_renter; //租车人id
@property(nonatomic, assign) NSInteger car_id;    //汽车id
@property(nonatomic, strong) NSString *start_date; //开始日期 yyyy-MM-dd
@property(nonatomic, strong) NSString *end_date;   //结束日期 yyyy-MM-dd
@property(nonatomic, assign) double order_amount;  //总价

@end
