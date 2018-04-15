//
//  OrderViewController.h
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//
//订单
#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *indicatorView; //指示标view
@property (weak, nonatomic) IBOutlet UIButton *orderIngBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderDoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderCancelBtn;
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

@property(strong, nonatomic) NSMutableArray *doneDataArr;  //已完成的订单数据源
@property(strong, nonatomic) NSMutableArray *ingDataArr;   //进行中的订单数据源
@property(strong, nonatomic) NSMutableArray *cancelDataArr;//已取消的订单数据源


@end
