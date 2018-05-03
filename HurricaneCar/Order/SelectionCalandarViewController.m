//
//  SelectionCalandarViewController.m
//  HurricaneCar
//
//  Created by Country on 2018/4/22.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "SelectionCalandarViewController.h"
#import <AlipaySDK/AlipaySDK.h>

#import "Order.h"
#import "SocketTool.h"

@interface SelectionCalandarViewController ()<JTCalendarDelegate, SocketResultDelegate>
{
    NSMutableArray *_datesSelected; //选择的日期
    double _totalPrice; //总价
}
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation SelectionCalandarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bottomView.layer.cornerRadius = 10;
    self.confirmBtn.layer.cornerRadius = 15;
    
    
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    
    self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    self.calendarManager.dateHelper.calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]; //中文地区
    
    [self.calendarManager setMenuView:_calenderMenuView];
    [self.calendarManager setContentView:_calanderContentView];
    [self.calendarManager setDate:[NSDate date]];
    
    _datesSelected = [NSMutableArray new];
    [self updataDays];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ---- Button Action
- (IBAction)confirmBtn:(UIButton *)sender {
    //生成订单
    Order *order = [[Order alloc] init];
    order.id_owner = self.car.userid;
    order.id_renter = @"2";
    order.car_id = self.car.carid;
    order.start_date = self.getCarTimeLabel.text;
    order.end_date = self.returnCarTimeLabel.text;
    order.order_amount = _totalPrice;
    
//    [[SocketTool singale] createOrderWithDelgete:self order:order];
    
    [self doZhiFubao];
    
}
#pragma mark ----
-(BOOL)isInDatesSelected:(NSDate *)date{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}
- (void)selectDates
{
    NSDate * startDate = [_datesSelected firstObject];
    NSDate * endDate = [_datesSelected lastObject];

    
    if([_calendarManager.dateHelper date:startDate isEqualOrAfter:endDate]){
        NSDate *nextDate = [_calendarManager.dateHelper addToDate:endDate days:1];
        while ([nextDate compare:startDate] == NSOrderedAscending) {
//            [_datesSelected addObject:nextDate];
            [_datesSelected insertObject:nextDate atIndex:_datesSelected.count-2];
            nextDate = [_calendarManager.dateHelper addToDate:nextDate days:1];
        }
    }
    else {
        NSDate *nextDate = [_calendarManager.dateHelper addToDate:startDate days:1];
        while ([nextDate compare:endDate] == NSOrderedAscending) {
//            [_datesSelected addObject:nextDate];
            [_datesSelected insertObject:nextDate atIndex:_datesSelected.count-2];
            nextDate = [_calendarManager.dateHelper addToDate:nextDate days:1];
        }
    }
    [_datesSelected sortUsingComparator:^NSComparisonResult(NSDate *obj1, NSDate *obj2) {
        return [_calendarManager.dateHelper date:obj1 isEqualOrAfter:obj2];
    }];
}

#pragma mark ---- CalendarManager delegate
//改变日历样式
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView{
  
    if([_calendarManager.dateHelper date:dayView.date isEqualOrBefore:[NSDate date]]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }else  if(![_calendarManager.dateHelper date:self.calanderContentView.date isTheSameMonthThan:dayView.date]){ //其他月份
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }else if([self isInDatesSelected:dayView.date]){ //是选中的日期
        dayView.circleView.hidden= NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }else{ // Another day of the current month
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.textLabel.text = @"今";
        dayView.textLabel.textColor = [UIColor redColor];
    }
}
-(void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView*)dayView{
    if ([_calendarManager.dateHelper date:dayView.date isEqualOrBefore:[NSDate date]]) {
        return ;
    }
    if(_datesSelected.count == 1 && ![_calendarManager.dateHelper date:[_datesSelected firstObject] isTheSameDayThan:dayView.date]){
        [_datesSelected addObject:dayView.date];
        [self selectDates];
        [_calendarManager reload];
        
    }else if(_datesSelected.count > 1){
        if ([self isInDatesSelected:dayView.date]) {
            if ([_calendarManager.dateHelper date:[_datesSelected firstObject] isTheSameDayThan:dayView.date] || [_calendarManager.dateHelper date:[_datesSelected lastObject] isTheSameDayThan:dayView.date]) {
                [_datesSelected removeObject:dayView.date];
                [UIView transitionWithView:dayView
                                  duration:.3
                                   options:0
                                animations:^{
                                    [_calendarManager reload];
                                    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                                } completion:nil];
            }
        }else{
            if ([_calendarManager.dateHelper date:dayView.date isEqualOrBefore:[_datesSelected firstObject]]) {
                NSDate *endDate = [_datesSelected lastObject];
                [_datesSelected removeAllObjects];
                [_datesSelected addObject:dayView.date];
                [_datesSelected addObject:endDate];
            }
            if ([_calendarManager.dateHelper date:dayView.date isEqualOrAfter:[_datesSelected lastObject]]) {
                NSDate *firstDate = [_datesSelected firstObject];
                [_datesSelected removeAllObjects];
                [_datesSelected addObject:firstDate];
                [_datesSelected addObject:dayView.date];
            }
            [self selectDates];
            [_calendarManager reload];
        }
        
    }else{
        if([self isInDatesSelected:dayView.date]){
            [_datesSelected removeObject:dayView.date];
            
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                [_calendarManager reload];
                                dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                            } completion:nil];
        }
        else{
            [_datesSelected addObject:dayView.date];
            
            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                [_calendarManager reload];
                                dayView.circleView.transform = CGAffineTransformIdentity;
                            } completion:nil];
        }
    }
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calanderContentView.date isTheSameMonthThan:dayView.date]){
        if([_calanderContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calanderContentView loadNextPageWithAnimation];
        }
        else{
            [_calanderContentView loadPreviousPageWithAnimation];
        }
    }
    [self updataDays];
}
////更新天数
-(void)updataDays{
    if (_datesSelected.count > 0) {
        self.totalDaysLabel.text = [NSString stringWithFormat:@"共计%lu天", (unsigned long)_datesSelected.count];
        _totalPrice  = _datesSelected.count * self.car.origin_price;
        self.moneyLabel.text =[NSString stringWithFormat:@"￥%.2f", _totalPrice];
        NSDate *firstDate = [_datesSelected firstObject];
        NSDate *lastDate = [_datesSelected lastObject];
        if ([_calendarManager.dateHelper date:firstDate isEqualOrAfter:lastDate]) {
            NSDate *tmpDate = firstDate;
            firstDate = lastDate;
            lastDate = tmpDate;
        }
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        self.getCarTimeLabel.text = [formater stringFromDate:firstDate];
        self.returnCarTimeLabel.text = [formater stringFromDate:lastDate];
    }else{
        self.getCarTimeLabel.text = @"请选择";
        self.returnCarTimeLabel.text = @"请选择";
        self.totalDaysLabel.text = @"共计0天";
        self.moneyLabel.text = @"￥0";
    }
}

#pragma mark ---- SanFangZhiFu
-(void)doZhiFubao{
    NSString *appID = @"2018042802605241";
    
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"";
    
//    if ([appID length] == 0 ||
//        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
//    {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
//                                                                       message:@"缺少appId或者私钥,请检查参数设置"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action){
//
//                                                       }];
//        [alert addAction:action];
//        [self presentViewController:alert animated:YES completion:^{ }];
//        return;
//    }
    
    NSString *orderInfoEncoded = @"%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22tt1111%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95Java%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.01%22%7D";
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode

    NSString *signedString = @"G3PZYT8PMQrUvipK3WakSY55Y6CvZ%2BgyOYsnjW58SyTeSt%2FzJuWJWczRBfnATafc8vKEdwmTRIA%2B6x4Z5bO0FakkTg%2FTiRTOWDPezV29r%2FMaIXUxdBFZR4HYDWd5pitQS9z3LqJ8QyH3eonZRYs8%2BZYkFUQ%2BDlvHqYN2fwxacIJV7fM31pvyB7x4a%2Ba5byUdrpeBs8AdPI6tjcFNALbwvNBfeAvyKHbqIF4BNX9kkyy%2B%2FAwxYhxCZsjJm7XQpfIPFnJ0owpcMzw2Did7bgwbABoIUKeflcgpcuu5D16k0NJE2i6ofvhWOM9bUIxsgqZouc1TQnZ%2F56qDy6BGTLXi1w%3D%3D";
   
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        NSString *appScheme = @"hurricaneCar";
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        NSString *newsign = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)@"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018042802605241&biz_content=%7B%22body%22%3A%22ceshishuju%22%2C%22out_trade_no%22%3A%221111%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22AppceshiJava%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%221.12%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fjufeng.xxx.com&sign=YDTb%2FdHSopCMglLnDwSg2WjehMAsqCu9bDjIT%2BztuJU9sGYRf33CViGEfzEoghY9NjZBgejoNrJf71k79lbnZdJm4Hi0L1F5zH88LGubYU3ntlmmWvNxuGSSEi0aYoHAfd3rPCaWY1vHRmomAMLSDp9%2Bhd7O6gule3saYYS181Nn2YfBJeC9pjqsGaUU6e%2Fyk%2BXsoMCKF%2B9ROGhRXoFAZUM1v7kaOmSnvcauy6r83xGYizUDlX1E2VHISq%2FZEwyXSN8oN6h6%2FjHZMs5JpmvrfvZNrk86XlGyP0tc1GClrWOg4QOn8WA0pbltsYGMffudTTmsEEft710bEipjE6%2Fcmg%3D%3D&sign_type=RSA&timestamp=2018-05-03+00%3A47%3A04&version=1.0", NULL, (CFStringRef)@"!*'();:@&=+ $,./?%#[]", kCFStringEncodingUTF8));
        // NOTE: 调用支付结果开始支付
        NSString *str = @"alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2018042802605241&biz_content=%7B%22body%22%3A%22ceshishuju%22%2C%22out_trade_no%22%3A%221111%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22AppceshiJava%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%221.12%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fjufeng.xxx.com&sign=YDTb%2FdHSopCMglLnDwSg2WjehMAsqCu9bDjIT%2BztuJU9sGYRf33CViGEfzEoghY9NjZBgejoNrJf71k79lbnZdJm4Hi0L1F5zH88LGubYU3ntlmmWvNxuGSSEi0aYoHAfd3rPCaWY1vHRmomAMLSDp9%2Bhd7O6gule3saYYS181Nn2YfBJeC9pjqsGaUU6e%2Fyk%2BXsoMCKF%2B9ROGhRXoFAZUM1v7kaOmSnvcauy6r83xGYizUDlX1E2VHISq%2FZEwyXSN8oN6h6%2FjHZMs5JpmvrfvZNrk86XlGyP0tc1GClrWOg4QOn8WA0pbltsYGMffudTTmsEEft710bEipjE6%2Fcmg%3D%3D&sign_type=RSA&timestamp=2018-05-03+00%3A47%3A04&version=1.0";
        
        [[AlipaySDK defaultService] payOrder:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}
-(void)doAPAuth{
    NSString *signedString = nil;
     if (signedString.length > 0) {
         NSString *appScheme = @"hurricaneCar";
         NSString *authInfoStr = @"";
         [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                          fromScheme:appScheme
                                            callback:^(NSDictionary *resultDic) {
                                                 NSLog(@"result = %@",resultDic);
                                                // 解析 auth code
                                                NSString *result = resultDic[@"result"];
                                                NSString *authCode = nil;
                                                if (result.length>0) {
                                                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                    for (NSString *subResult in resultArr) {
                                                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                            authCode = [subResult substringFromIndex:10];
                                                            break;
                                                        }
                                                    }
                                                }
                                                NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                            }];
     }
}

#pragma mark ---- SocketTool
//订单生成回调
-(void)createOrderSuccess:(BOOL)success withData:(NSDictionary *)data{
    if (success) {
        if ([data[@"success"] longValue]== 1) {
            
            [[SocketTool singale] fukuanWithDelegate:self uid:[data[@"latest_id"] longValue] amount:_totalPrice];
        }
    }
}

@end
