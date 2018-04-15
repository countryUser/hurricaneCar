//
//  LoginInputView.h
//  HurricaneCar
//
//  Created by Country on 2017/12/19.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

/**
 * 输入账号密码view
 */
#import <UIKit/UIKit.h>

typedef void(^Login)(NSString *name, NSString *password);
typedef void(^ToRegister)();
typedef void(^FindPassword)();
@interface LoginInputView : UIView

@property(nonatomic, copy) Login loginBlock;               //登录
@property(nonatomic, copy) ToRegister toRegisterBlock;         //跳转到注册
@property(nonatomic, copy) FindPassword findPasswordBlock; //找回密码
@end


#pragma mark - 
#pragma mark - 用户注册 view

typedef void(^BackLogin)();
typedef void(^Register)(NSString *userName, NSString *password);

@interface RegisterView : UIView
@property(nonatomic, copy) BackLogin backLoginBlock; //返回登录block
@property(nonatomic, copy) Register registerBlock;   //注册block
@end
