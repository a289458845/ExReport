//
//  ZWSuspiciousTableViewCell.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWSusUnearthedDetailRankModel,ZWInadvanceSiteRegionModel,ZWSiteStaticModel,ZWBlackSiteRegionModel;
@interface ZWSuspiciousTableViewCell : UITableViewCell

@property (strong, nonatomic)ZWSusUnearthedDetailRankModel *model;
@property (strong, nonatomic)ZWInadvanceSiteRegionModel *regionModel;
@property (strong, nonatomic)ZWSiteStaticModel *siteStaticModel;
@property (strong, nonatomic)ZWBlackSiteRegionModel *blackModel;



@end
