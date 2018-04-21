//
//  OrderViewController.m
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"

typedef NS_ENUM(NSInteger, OrderType){
    OrderType_ing,  //进行中的订单
    OrderType_done, //已完成的订单
    OrderType_cancel//已取消的订单
};

@interface OrderViewController ()

@property(nonatomic, assign) OrderType orderType; //订单类型

@end

@implementation OrderViewController

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"订单";
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.orderType = OrderType_done; //默认为 已完成订单
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button Action
//进行中
- (IBAction)orderImgBtn:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.indicatorView.frame;
        rect.origin.x = self.orderIngBtn.frame.origin.x;
        self.indicatorView.frame = rect;
    }];

    self.orderType = OrderType_ing;
}
//已完成
- (IBAction)orderDoneBtn:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.indicatorView.frame;
        rect.origin.x = self.orderDoneBtn.frame.origin.x;
        self.indicatorView.frame = rect;
    }];
    self.orderType = OrderType_done;
}
//取消
- (IBAction)orderCancelBtn:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{        
        CGRect rect = self.indicatorView.frame;
        rect.origin.x = self.orderCancelBtn.frame.origin.x;
        self.indicatorView.frame = rect;
    }];
    self.orderType = OrderType_cancel;
}


#pragma mark - UITableViewDataSource && UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"OrderCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"OrderTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///点击cell
    switch (self.orderType) {
        case OrderType_ing:
            break;
        case OrderType_done:
            break;
        case OrderType_cancel:
            break;
    }
}
@end
