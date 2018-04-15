//
//  LoginViewController.m
//  HurricaneCar
//
//  Created by Country on 2017/12/19.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "LoginViewController.h"

#import "ChoiceViewController.h"
#import "OrderViewController.h"
#import "CollectViewController.h"
#import "MineViewController.h"

#import "LoginInputView.h"

#import "SocketTool.h"

@interface LoginViewController ()<SocketResultDelegate>

@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) LoginInputView *loginInputView;
@property(nonatomic, strong) RegisterView *registerView; //注册view

@end

const NSString *kBgImagePath = @"index.jpg";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:ScreenBound];
    _bgImageView.image = [UIImage imageNamed:kBgImagePath];
    [self.view addSubview:_bgImageView];
    
    UIView *grayView = [[UIView alloc] initWithFrame:ScreenBound];
    grayView.backgroundColor = [UIColor lightGrayColor];
    grayView.alpha = 0.3;
    [self.view addSubview:grayView];
    
    
    
    _loginInputView = [[LoginInputView alloc] initWithFrame:CGRectMake(0, ScreenHeight * 0.325, ScreenWidth, ScreenHeight*0.35)];
    [self.view addSubview:_loginInputView];
    
    //注册view
    _registerView = [[RegisterView alloc] initWithFrame:CGRectMake(ScreenWidth+5, ScreenHeight * 0.3, ScreenWidth-10, ScreenHeight*0.4)];
    [self.view addSubview:_registerView];
    
    __weak LoginViewController *_tmpWeakSelf;
    _loginInputView.loginBlock = ^(NSString *name, NSString *password){
        
        [self login];
    };
    _loginInputView.toRegisterBlock = ^(){
        [self toRegisterView];
    };
    
    _registerView.registerBlock = ^(NSString *name, NSString *password){
        [[SocketTool singale] registerUser:name pass:password];
    };
    _registerView.backLoginBlock = ^(){
        [self backLoginView];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 私有方法
-(void)login{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    for (UIView *vc in window.subviews) {
        [vc removeFromSuperview];
    }
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    ChoiceViewController *choice = [[ChoiceViewController alloc] initWithNibName:@"ChoiceViewController" bundle:nil];
    choice.tabBarItem.title = @"选车";
    OrderViewController *order = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    order.tabBarItem.title = @"订单";

    CollectViewController *collect = [[CollectViewController alloc] initWithNibName:@"CollectViewController" bundle:nil];
    collect.title = @"车库";
    UINavigationController *collectNav = [[UINavigationController alloc] initWithRootViewController:collect];
    MineViewController *mine = [[MineViewController alloc] initWithNibName:@"MineViewController" bundle:nil];
    mine.tabBarItem.title = @"我的";
    [tab setViewControllers:@[choice, order, collectNav, mine]];
    window.rootViewController = tab;
}

//跳转到注册界面
-(void)toRegisterView{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect loginFrame = _loginInputView.frame;
        loginFrame.origin.x -= ScreenWidth;
        _loginInputView.frame = loginFrame;
        
        CGRect registerFrame = _registerView.frame;
        registerFrame.origin.x -= ScreenWidth;
        _registerView.frame = registerFrame;
    }];
}
-(void)backLoginView{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect registerFrame = _registerView.frame;
        registerFrame.origin.x += ScreenWidth;
        _registerView.frame = registerFrame;
        
        CGRect loginFrame = _loginInputView.frame;
        loginFrame.origin.x += ScreenWidth;
        _loginInputView.frame = loginFrame;
    }];

}

#pragma mark - SoketResultDelegate

///注册请求结果
-(void)registerResult:(BOOL)success withData:(NSDictionary *)data{
    if (!success) {
        NSLog(@"注册失败");
    }
    
}

@end
