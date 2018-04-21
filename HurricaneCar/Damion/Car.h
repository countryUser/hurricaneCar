//
//  Car.h
//  HurricaneCar
//
//  Created by Country on 2018/4/19.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property(nonatomic, assign) NSInteger visual_type; //展示类型
@property(nonatomic, assign) NSInteger carid;
@property(nonatomic, strong) NSString *car_name; //车名字
@property(nonatomic, strong) NSString *carbrand; //品牌

@property(nonatomic, strong) NSData *car_leftFront; //左前图片
@property(nonatomic, strong) NSData *car_leftBack;
@property(nonatomic, strong) NSData *car_inner;
@property(nonatomic, strong) NSData *car_back;
@property(nonatomic, strong) NSData *car_img;

@property(nonatomic, assign) NSInteger rank_no;


@property(nonatomic, assign) NSInteger userid;
@property(nonatomic, strong) NSString *car_no; //车牌号
@property(nonatomic, assign) long origin_price; //出租的价格

@end
