//
//  ZWCarInstallDeveiceSituationCollectionViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeveiceSituationCollectionViewCell.h"
#import "ZWVehicleImgsModel.h"
//#import "SDWebImageManager.h"
//#import "SDWebImageDownloader.h"
//#import "UIImage+GIF.h"
//#import "NSData+ImageContentType.h"
#import "UIImageView+WebCache.h"
@interface ZWCarInstallDeveiceSituationCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation ZWCarInstallDeveiceSituationCollectionViewCell
- (void)setModel:(ZWVehicleImgsModel *)model{
    _model = model;
    
    NSString *imgUrlStr =  model.ImgUrl;
    NSURL *imgUrl = [[NSURL alloc]initWithString:[imgUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_iconView sd_setImageWithURL:imgUrl];
    
//    MJWeakSelf
//    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:_model.ImgUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        weakSelf.iconView.image = image;
//
//    }];
    _titleLab.text = model.OptionName;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLab.font = kSystemFont(30);
    self.titleLab.textColor = COLORWITHHEX(kColor_6D737F);
}



@end
