//
//  TZAssetCell.h
//  TZImagePickerController
//
//  Created by yuchao on 17/11/2.
//  Copyright © 2017年 yuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {
    TZAssetCellTypePhoto = 0,
    TZAssetCellTypeLivePhoto,
    TZAssetCellTypePhotoGif,
    TZAssetCellTypeVideo,
    TZAssetCellTypeAudio,
} TZAssetCellType;

@class TZAssetModel;
@interface TZAssetCell : UICollectionViewCell

@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (nonatomic, strong) TZAssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) TZAssetCellType type;
@property (nonatomic, assign) BOOL allowPickingGif;
@property (nonatomic, assign) BOOL allowPickingMultipleVideo;
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) int32_t imageRequestID;

@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;

@property (nonatomic, assign) BOOL showSelectBtn;
@property (assign, nonatomic) BOOL allowPreview;

@end


@class TZAlbumModel;

@interface TZAlbumCell : UITableViewCell

@property (nonatomic, strong) TZAlbumModel *model;
@property (weak, nonatomic) UIButton *selectedCountButton;

@end


@interface TZAssetCameraCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end