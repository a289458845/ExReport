//
//  ZWStatisticalReportsReusableHeader.m
//  Muck
//
//  Created by 张威 on 2018/7/26.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsReusableHeader.h"
#import <ExReport/ExDefine.h>
@interface ZWStatisticalReportsReusableHeader ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end
@implementation ZWStatisticalReportsReusableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLab.font = kSystemFont(28);
    self.titleLab.textColor = COLORWITHHEX(kColor_6D737F);
}

@end
