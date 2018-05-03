//
//  CarInfoViewController.m
//  HurricaneCar
//
//  Created by Country on 2018/4/17.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "CarInfoViewController.h"
#import "LoginViewController.h"
#import "SelectionCalandarViewController.h"

@interface CarInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *carBrand; //品牌
@property (weak, nonatomic) IBOutlet UILabel *carModel;//车型
@property (weak, nonatomic) IBOutlet UILabel *transmission;//变速器 手动（MT）/ 自动（AT）
@property (weak, nonatomic) IBOutlet UILabel *displacement; //涡轮增加，4.0T(4.0升排气量的发动机增设了进气涡轮增压装置)/1.8L(1.8升排气量)

@property (weak, nonatomic) IBOutlet UILabel *carBrand_bottom;
@property (weak, nonatomic) IBOutlet UILabel *carModel_bottom;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation CarInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.bottomView.layer.cornerRadius = 15;
    self.buyBtn.layer.cornerRadius = 15;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swap =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swapGesture:)];
    [self.view addGestureRecognizer:swap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCar:(Car *)car{
    _car = car;
    self.carBrand.text = _car.car_name;
    self.carModel.text = @"型号";
    self.transmission.text = @"变速箱";
    self.displacement.text = @"4.0T";
    
    [self.buyBtn setTitle:[NSString stringWithFormat:@"￥ %.2f", _car.origin_price] forState:UIControlStateNormal];
}
#pragma mark ---- gesture Action
-(void)swapGesture:(UISwipeGestureRecognizer *)gesture{
    if(gesture.direction == UISwipeGestureRecognizerDirectionRight){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark
//租车Action
- (IBAction)buyAction:(UIButton *)sender {
    self.hidesBottomBarWhenPushed = YES;
    SelectionCalandarViewController *calandarVC = [[SelectionCalandarViewController alloc] initWithNibName:@"SelectionCalandarViewController" bundle:nil];
    [self.navigationController pushViewController:calandarVC animated:YES];
    /****
    if (![HCArchive unLoginStatus]) {
        NSLog(@"未登录");
        self.hidesBottomBarWhenPushed = YES;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        NSLog(@"已经登录");
    }
     ****/
}
//取消
- (IBAction)cancelAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}


@end
