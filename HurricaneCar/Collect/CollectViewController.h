//
//  CollectViewController.h
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//
// 收藏Controller
#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource; //数据源

@end
