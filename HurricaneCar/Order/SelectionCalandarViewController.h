//
//  SelectionCalandarViewController.h
//  HurricaneCar
//
//  Created by Country on 2018/4/22.
//  Copyright © 2018年 Future9988x. All rights reserved.
//
/**
 * 选择日期viewController
 */
#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "Car.h"

@interface SelectionCalandarViewController : UIViewController
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calenderMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calanderContentView;
@property (weak, nonatomic) IBOutlet UILabel *getCarTimeLabel;//取车时间
@property (weak, nonatomic) IBOutlet UILabel *returnCarTimeLabel; //还车时间
@property (weak, nonatomic) IBOutlet UILabel *totalDaysLabel; //总天数
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel; //总金额
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn; //确认按钮

@property(nonatomic, strong) Car *car;
@end
