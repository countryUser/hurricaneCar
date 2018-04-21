//
//  AuthentificationViewController.m
//  HurricaneCar
//
//  Created by Country on 2018/4/21.
//  Copyright © 2018年 Future9988x. All rights reserved.
//

#import "AuthentificationViewController.h"
#import "TZImagePickerController.h"

@interface AuthentificationViewController ()<TZImagePickerControllerDelegate>{
    int _type; // 0-正面，1-反面
    BOOL _isDoneLicence_1; //正面选择完毕
    BOOL _isDoneLicence_2; //反面选择完毕
}
@property (weak, nonatomic) IBOutlet UIImageView *drivingLicence_1; //驾驶证正页图片
@property (weak, nonatomic) IBOutlet UILabel *statusLincence_1;
@property (weak, nonatomic) IBOutlet UIImageView *drivingLicence_2;//驾驶证副页
@property (weak, nonatomic) IBOutlet UILabel *statusLicence_2;


@end

@implementation AuthentificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer *tap_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture1:)];
    [self.drivingLicence_1 addGestureRecognizer:tap_1];
    
    UITapGestureRecognizer *tap_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture2:)];
    [self.drivingLicence_2 addGestureRecognizer:tap_2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- Gesture Action
-(void)tapGesture1:(UITapGestureRecognizer *)gesture{
    _type = 0;
    [self showImagePicker];
}
-(void)tapGesture2:(UITapGestureRecognizer *)gesture{
    _type = 1;
    [self showImagePicker];
}
#pragma mark ----
-(void)showImagePicker{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    //原图
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = YES; //在现实内拍照
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO;
    imagePickerVc.sortAscendingByModificationDate = NO;//照片排列按修改时间升序
    //单选模式，maxImageCount 为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    
    imagePickerVc.isStatusBarDefault = NO;
    
    imagePickerVc.navigationBar.barTintColor = [UIColor redColor];
    
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark ---- TZImagePickerControllerDelegate
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    NSArray *imageArray = [NSMutableArray arrayWithArray:photos];
    NSArray *assetsArray = [NSMutableArray arrayWithArray:assets];
    
    UIImage *image = [imageArray firstObject];
    if (_type == 0) {
        self.drivingLicence_1.image = image;
        _isDoneLicence_1 = YES;
    }else if (_type == 1){
        self.drivingLicence_2.image = image;
    }
}

#pragma mark ---- UIButton
//取消
- (IBAction)cancelAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
