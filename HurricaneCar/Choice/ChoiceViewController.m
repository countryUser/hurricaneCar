//
//  ChoiceViewController.m
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "ChoiceViewController.h"

#import "CarInfoViewController.h"

#import "RecomendTableViewCell.h"

#import "Car.h"

#import "SocketTool.h"
#import "MJExtension.h"

@interface ChoiceViewController ()<UITableViewDelegate, UITableViewDataSource,SocketResultDelegate>
{
    NSIndexPath *_selectIndexPath;
}

@property(nonatomic,strong) NSArray *carsArr;

@end

@implementation ChoiceViewController

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"选车";
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[SocketTool singale] getCarListWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---- SocketResultDelegate
-(void)registerResult:(BOOL)success withData:(NSDictionary *)data{
    if(success){
        NSArray *arr = data[@"ret_val"];

        self.carsArr = [Car mj_objectArrayWithKeyValuesArray:arr];
        [self.tableView reloadData];
    }
}

#pragma mark ---- UITableViewDataSourece && Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"RecomentCell";
    RecomendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"RecomendTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    cell.car = self.carsArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    CarInfoViewController *infoVC = [[CarInfoViewController alloc] initWithNibName:@"CarInfoViewController" bundle:nil];
    infoVC.car = self.carsArr[indexPath.row];
    [self.navigationController pushViewController:infoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
// TODO: 即将进入高亮状态
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath  {
    return YES;
}
// TODO: 结束高亮状态
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  95;
}



#pragma mark ---- 懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_CLEAR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
