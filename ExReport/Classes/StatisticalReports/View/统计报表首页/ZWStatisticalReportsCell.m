//
//  ZWStatisticalReportsCell.m
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsCell.h"
#import "UIImageView+WebCache.h"

@interface ZWStatisticalReportsCell ()

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *titleLab;
@property (nonatomic, strong) NSDictionary *menuIcon;

@end

@implementation ZWStatisticalReportsCell


- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleLab.text = dict[@"Name"];
//    _iconView.image = [UIImage imageNamed:[self selectedIconStringWithUrl:dict[@"Url"]]];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[rTools appendNetworkImageUrl:dict[@"IconClass"]]]];
//    _iconView.clipsToBounds = YES;
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
}

- (NSString *)selectedIconStringWithUrl:(NSString *)url{
    return self.menuIcon[url][@"normal"];
}

- (NSDictionary *)menuIcon
{
    if (!_menuIcon) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuState.plist" ofType:nil];
        _menuIcon = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _menuIcon;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstaint];
    }
    return self;
}


- (void)setupUI{
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = COLORWITHHEX(kColor_6D737F);
    self.titleLab.font = kSystemFont(28);
    
    self.iconView = [[UIImageView alloc]init];
    
    [self addSubview:self.titleLab];
    [self addSubview:self.iconView];
}

- (void)setupConstaint{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kWidth(72), kWidth(72)));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconView.mas_bottom).offset(kWidth(10));
        make.height.mas_equalTo(kWidth(30));
        
    }];
    
    
//    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(kWidth(20));
//        make.centerX.equalTo(self);
////        make.size.mas_equalTo(CGSizeMake(kWidth(70), kWidth(70)));
//    }];
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.iconView.mas_bottom).offset(kWidth(20));
//        make.centerX.equalTo(self);
//    }];
    
    
}








@end
