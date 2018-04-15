//
//  ChoiceViewController.m
//  HurricaneCar
//
//  Created by Country on 2017/12/27.
//  Copyright © 2017年 Future9988x. All rights reserved.
//

#import "ChoiceViewController.h"

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"选车";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
