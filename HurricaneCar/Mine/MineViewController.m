//
//  MineViewController.m
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "AuthentificationViewController.h"
@interface MineViewController ()

@property(nonatomic, strong) NSArray *infoArr;

@end

@implementation MineViewController

-(void)awakeFromNib{
    [super awakeFromNib];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"个人资料";
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoArr = @[@"钱包", @"信息认证", @"紧急联系人", @"联系客服"];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - button Action
///退出登录
- (IBAction)logout:(id)sender {
    //TODO...
    [HCArchive saveLoginStatus:NO]; //退出登录
    
    self.hidesBottomBarWhenPushed = YES;
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"infoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    cell.textLabel.text = self.infoArr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //TODO..
    if (indexPath.row == 0) { //钱包
        
    }else if(indexPath.row == 1){ //信息认证
        self.hidesBottomBarWhenPushed = YES;
        AuthentificationViewController *autVc = [[AuthentificationViewController alloc] initWithNibName:@"AuthentificationViewController" bundle:nil];
        [self.navigationController pushViewController:autVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
        
    }
}
@end
