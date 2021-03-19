//
//  ZWStatisticalReportsItemsView.m
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsItemsView.h"
#import "ZWContentButton.h"
#import "UIImageView+WebCache.h"
@interface ZWStatisticalReportsItemsView ()

@property (nonatomic, strong) NSDictionary *menuIcon;

@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *btnsArray;

@end

@implementation ZWStatisticalReportsItemsView


- (void)setMenus:(NSArray *)Menus{
    _Menus = Menus;
    
    NSMutableArray *btns = @[].mutableCopy;
    for (int i = 0; i < Menus.count; i++) {
        
        ZWContentButton *btn = [[ZWContentButton alloc]init];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

        NSString * icon = [NSString stringWithFormat:@"%@/%@",[ExService manager].baseUrl,Menus[i][@"IconClass"]];
         
        [btn.imgView sd_setImageWithURL:[NSURL URLWithString:icon]];
        
        btn.titleLab.text = Menus[i][@"Name"];
        [self addSubview:btn];
        [btns addObject:btn];
        
    }
        self.btnsArray = btns;
    
    //        UIImageView *icon = [[UIImageView alloc] init];
    //        icon.image = [UIImage imageNamed:[self selectedIconStringWithUrl:Menus[i][@"Url"]]];
    //        icon.contentMode = UIViewContentModeCenter;
    //        UILabel *title = [[UILabel alloc] init];
    //        title.text = Menus[i][@"Name"];
    //        title.font = kSystemFont(28);
    //        title.textColor = COLORWITHHEX(kColor_6D737F);
    //        title.textAlignment = NSTextAlignmentCenter;
    //        title.numberOfLines = 0;
    //        [self addSubview:icon];
    //        [self addSubview:title];
    
    //        [icons addObject:icon];
    //        [titles addObject:title];
    
    //    self.titles = titles;
    //    self.icons = icons;
    


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat margin = 10;
    CGFloat titleW = self.bounds.size.width/3-2*margin;
    for (int i = 0; i < self.Menus.count; i++) {
        ZWContentButton *btn = self.btnsArray[i];
    btn.frame = CGRectMake(i%3*(self.bounds.size.width/3)+margin, i/3*(self.bounds.size.height/2)+margin, titleW, self.bounds.size.height/2-margin*2);
        
 
        
//        UIImageView *icon = self.icons[i];
//        UILabel *title = self.titles[i];
//        icon.frame = CGRectMake(i%3*(self.bounds.size.width/3)+margin, i/3*(self.bounds.size.height/2)+margin, titleW, iconW);
//        title.frame = CGRectMake(i%3*(self.bounds.size.width/3)+margin, CGRectGetMaxY(icon.frame)+margin, titleW, self.bounds.size.height/2-iconW-margin*2);
    }
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
    return self.menuIcon[url][@"selected"];
}

- (void)clickBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(ZWStatisticalReportsItemsViewDidSelected:didSelectIndex:)]) {
        [self.delegate ZWStatisticalReportsItemsViewDidSelected:self didSelectIndex:sender.tag];
    }

    
}

@end
