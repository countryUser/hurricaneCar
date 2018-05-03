//
//  LoginInputView.m
//  HurricaneCar
//
//  Created by Country on 2017/12/19.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "LoginInputView.h"



const CGFloat kPaddingLR = 30; ///距离手机屏幕左边和右边的距离
const CGFloat kPaddingTB = 20; ///上下控件的间隔距离

@interface LoginInputView ()

@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton   *loginBtn;   //登录按钮
@property (nonatomic, strong) UIButton   *findingBtn; //找回密码
@property (nonatomic, strong) UIButton   *registerBtn;//注册


@end


@implementation LoginInputView

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat height = (frame.size.height - 3*kPaddingTB) / 4.0;
        CGFloat width = frame.size.width - 2 * kPaddingLR;
        
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(kPaddingLR, 0, width, height)];
        _userNameTF.textColor = [UIColor whiteColor];
        _userNameTF.layer.cornerRadius = 5;
        _userNameTF.layer.borderWidth = 1;
        _userNameTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, height)];
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(kPaddingLR, CGRectGetMaxY(_userNameTF.frame)+kPaddingTB, width, height)];
        _passwordTF.textColor = [UIColor whiteColor];
        _passwordTF.layer.cornerRadius = 5;
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, height)];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPaddingLR, CGRectGetMaxY(_passwordTF.frame)+kPaddingTB, width, height)];
        _loginBtn.backgroundColor = [UIColor redColor];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = 0.2;
        [_loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        CGFloat width_3 = width / 3.0;
        _findingBtn = [[UIButton alloc] initWithFrame:CGRectMake(kPaddingLR, CGRectGetMaxY(_loginBtn.frame), width_3, height)];
        [_findingBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_findingBtn addTarget:self action:@selector(findPassword:) forControlEvents:UIControlEventTouchUpInside];
        
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_findingBtn.frame)+width_3, _findingBtn.frame.origin.y, width_3, height)];
        [_registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(toRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_userNameTF];
        [self addSubview:_passwordTF];
        [self addSubview:_loginBtn];
        [self addSubview:_findingBtn];
        [self addSubview:_registerBtn];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
}



#pragma mark -- Button Action
-(void)loginAction{
    
    if (self.loginBlock) {
        self.loginBlock(self.userNameTF.text, self.passwordTF.text);
    }
}
-(void)toRegisterAction:(UIButton *)sender{
    if (self.toRegisterBlock) {
        self.toRegisterBlock();
    }
}
-(void)findPassword:(UIButton *)sender{
    if (self.findPasswordBlock) {
        self.findPasswordBlock();
    }
}


@end


#pragma mark - 
#pragma mark - 注册view

@interface RegisterView ()
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *rePassqordTF;
@property (nonatomic, strong) UIButton *registerBtn; //注册按钮
@property (nonatomic, strong) UIButton *backLoginBtn; //返回登录
@end

@implementation RegisterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat height = (frame.size.height - 4 * 5) / 5;
        CGFloat width = frame.size.width;
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _userNameTF.textColor = [UIColor whiteColor];
        _userNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _userNameTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _userNameTF.layer.borderWidth = 1;
        _userNameTF.layer.cornerRadius = 5;
        _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, height)];
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:_userNameTF];
        
        CGFloat y = CGRectGetMaxY(_userNameTF.frame) + 5;
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, y, width, height)];
        _passwordTF.textColor = [UIColor whiteColor];
        _passwordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        _passwordTF.layer.borderColor = [UIColor whiteColor].CGColor;
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.layer.cornerRadius = 5;
        _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, height)];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        [self addSubview:_passwordTF];
        
        y = CGRectGetMaxY(_passwordTF.frame) + 5;
        _rePassqordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, y, width, height)];
        _rePassqordTF.textColor = [UIColor whiteColor];
        _rePassqordTF.placeholder = @"确认密码";
        [self addSubview:_rePassqordTF];
        
        y = CGRectGetMaxY(_rePassqordTF.frame) + 5;
        _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, width, height)];
        _registerBtn.backgroundColor = [UIColor redColor];
        [_registerBtn setTitle:@"注  册" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_registerBtn];
        
        y = CGRectGetMaxY(_registerBtn.frame) + 5;
        _backLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, width, height)];
        _backLoginBtn.backgroundColor = [UIColor redColor];
        [_backLoginBtn setTitle:@"返回登录" forState:UIControlStateNormal];
        [_backLoginBtn addTarget:self action:@selector(backLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backLoginBtn];
    }
    return self;
}

//返回登录
-(void)backLogin:(UIButton *)sender{
    if(self.backLoginBlock){
        self.backLoginBlock();
    }
}
//注册
-(void)registerAction:(UIButton *)sender{
    if (![self.passwordTF.text isEqualToString:self.rePassqordTF.text]) {
        NSLog(@"密码不一致");
        return;
    }
    
    if (self.registerBlock) {
        self.registerBlock(self.userNameTF.text, self.passwordTF.text);
    }
}

@end
