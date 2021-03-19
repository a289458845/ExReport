//
//  ZWCompanyBasicDetailInfoSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/23.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyBasicDetailInfoSectionHeaderView.h"


@interface ZWCompanyBasicDetailInfoSectionHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *unClosenessBtn;
@property (weak, nonatomic) IBOutlet UIButton *carOverspeedBtn;
@property (weak, nonatomic) IBOutlet UIButton *carOverloadBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation ZWCompanyBasicDetailInfoSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    [self.allBtn setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];

    
    [self.unClosenessBtn setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];

    [self.carOverspeedBtn setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];
  
    [self.carOverloadBtn setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];
  

    
}

- (IBAction)allBtnClick:(UIButton *)sender {
   
    
}




@end
