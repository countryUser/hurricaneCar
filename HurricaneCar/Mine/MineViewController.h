//
//  MineViewController.h
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//
// 我的Controller
#import <UIKit/UIKit.h>

@interface MineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headImage; //头像image
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //名字label

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel; //余额label
@property (weak, nonatomic) IBOutlet UILabel *valuationLabel; //评价label

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@end
