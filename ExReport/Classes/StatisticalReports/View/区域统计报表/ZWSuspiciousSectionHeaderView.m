//
//  ZWSuspiciousSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSuspiciousSectionHeaderView.h"
#import <ExReport/ExDefine.h>
@interface ZWSuspiciousSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation ZWSuspiciousSectionHeaderView

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
    
    self.titleLab.font = kSystemFont(28);
    self.titleLab.textColor = COLORWITHHEX(kColor_6D737F);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLab.text = title;
}

@end
