//
//  ZWStatisticalReportsCommonView.m
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsCommonView.h"
#import "ZWContentButton.h"
#import "UIImageView+WebCache.h"
@interface ZWStatisticalReportsCommonView ()
@property(nonatomic,strong)UILabel *commonTypeLab;
@property(nonatomic,strong)UIView *lineView;
@property (nonatomic, strong) NSArray *commonMenuArray;
@property (nonatomic, strong) NSArray *btnsArray;

@property (nonatomic, strong) NSDictionary *menuIcon;
@end

@implementation ZWStatisticalReportsCommonView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];


    }
    return self;
}


- (void)setupUI{
    self.commonTypeLab = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left andString:@"常用统计报表"];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
   

    
    NSMutableArray *btns = @[].mutableCopy;
    for (int i = 0; i < self.commonMenuArray.count; i++) {
        ZWContentButton *btn = [[ZWContentButton alloc]init];
        btn.tag = [self.commonMenuArray[i][@"Url"] integerValue];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//        NSString *imgStr = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ztc_url"],self.commonMenuArray[i][@"IconClass"]];
//        NSURL *url = [[NSURL alloc]initWithString:imgStr];
//        [btn.imgView sd_setImageWithURL:url];
        
        /**  本地图片*/
        btn.imgView.image = [UIImage imageNamed:[self selectedIconStringWithUrl:self.commonMenuArray[i][@"Url"]]];
//        btn.imgView.contentMode = UIViewContentModeScaleAspectFill;
        btn.titleLab.text = self.commonMenuArray[i][@"Name"];

        [self addSubview:btn];
        [btns addObject:btn];
        
    }
    self.btnsArray = btns;
    
    [self addSubview:self.commonTypeLab];
    [self addSubview:self.lineView];
 

}



- (void)layoutSubviews{
    [super layoutSubviews];
   
    self.lineView.frame = CGRectMake(0, 0, self.bounds.size.width, kWidth(1));
    self.commonTypeLab.frame = CGRectMake(10, CGRectGetMaxY(self.commonTypeLab.frame), kWidth(300),44);
    
    CGFloat margin = 10;
    CGFloat titleW = self.bounds.size.width/3-2*margin;
    for (int i = 0; i < self.commonMenuArray.count; i++) {
        ZWContentButton *btn = self.btnsArray[i];
        btn.frame = CGRectMake(i%3*(self.bounds.size.width/3)+margin, 44+i/3*(self.bounds.size.height/3)+margin, titleW, self.bounds.size.height/3-margin*3);

    }

}


- (NSArray *)commonMenuArray{
    if (!_commonMenuArray) {
        NSString *filePathName = [kDocPath stringByAppendingPathComponent:@"common_meum.plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePathName];
        
        _commonMenuArray = dataArray;
    }
    return _commonMenuArray;
}


- (NSDictionary *)menuIcon
{
    if (!_menuIcon) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuState.plist" ofType:nil];
        _menuIcon = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _menuIcon;
}

- (NSString *)selectedIconStringWithUrl:(NSString *)url
{
    return self.menuIcon[url][@"normal"];
}



- (void)clickBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(tatisticalReportsCommonViewDidSelected:WithUrl:)]) {
        [self.delegate tatisticalReportsCommonViewDidSelected:self WithUrl:sender.tag];
    }

}



@end
