//
//  RecomendTableViewCell.m
//  HurricaneCar
//
//  Created by Country on 2018/1/3.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "RecomendTableViewCell.h"
@interface RecomendTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *carImage; //车图片
@property (weak, nonatomic) IBOutlet UILabel *carName; //车名字
@property (weak, nonatomic) IBOutlet UILabel *priceLabel; //价格

@end
@implementation RecomendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCar:(Car *)car{
    _car = car;
    self.carImage.image = [UIImage imageWithData:_car.car_img];
    self.carName.text = _car.car_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %.2f/日", _car.origin_price];
}

@end
