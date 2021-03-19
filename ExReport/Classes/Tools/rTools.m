//
//  rTools.m
//  ExReport
//
//  Created by exsun on 2021/3/16.
//

#import "rTools.h"

@implementation rTools

+(NSString *)getResrouceBundleWithName:(NSString *)name type:(NSString *)type folderName:(NSString *)fName
{
    
    NSString * p;
    NSBundle * bd = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"ExReport" ofType:@"bundle"]];

    p = [bd pathForResource:[NSString stringWithFormat:@"%@/%@",fName,name] ofType:type];
    
    return p;
}

+(UIImage *)getResourceImageName:(NSString *)name
{
    NSString * path = [self getResrouceBundleWithName:name type:@"png" folderName:@"Image"];
    UIImage * img = [UIImage imageWithContentsOfFile:path];
    return img;
}

+(id)getCellWithName:(NSString *)cellName
{
    
    return  [[[NSBundle bundleForClass:[self class]]loadNibNamed:cellName owner:nil options:nil]firstObject];
}

+(NSString *)appendNetworkImageUrl:(NSString *)imagePath
{
    NSString * url = [NSString stringWithFormat:@"%@/%@",[ExService manager].baseUrl,imagePath];
    return url;
}



+ (void)filterStatisticalSectionMeumWithSource:(NSArray *)source{
    NSString *statisticalPathString = [kDocPath stringByAppendingPathComponent:@"filter.plist"];
    NSString *statisticalSectionPathString = [kDocPath stringByAppendingPathComponent:@"filterSection.plist"];
    
    //    [source enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj[@"Name"] isEqualToString:@"数据应用"]) {
    //数据应用
    //            NSArray *dateMeum = obj[@"childMenu"];
    
    //        [source enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                if ([obj[@"Name"] isEqualToString:@"统计报表"]) {
    
    //                    NSArray *statisticalMeum =  obj[@"childMenu"];
    NSArray *statisticalMeum =  source;
    NSMutableArray *filterArray = [NSMutableArray array];
    NSMutableArray *filterSectionArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < statisticalMeum.count; i++ ) {//遍历统计报表
        NSDictionary *meum = statisticalMeum[i];
        NSString *url = meum[@"Url"];
        NSArray *items = meum[@"childMenu"];
        
        
        if ([url isEqualToString:@"1111"]) {//区域统计报表  两组
            
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            
            NSMutableArray *section1 = [NSMutableArray array];
            NSMutableArray *section2 = [NSMutableArray array];
            
            NSDictionary *one = [self containWithchildMenu:items Url:@"11111"];//区域统计报表
            if (one) {
                [section1 addObject:one];
            }
            NSDictionary *two = [self containWithchildMenu:items Url:@"11112"];//区域消纳量
            if (two) {
                [section1 addObject:two];
            }
            NSDictionary *three = [self containWithchildMenu:items Url:@"11113"];//区域可疑工地
            if (three) {
                [section1 addObject:three];
            }
            NSDictionary *four = [self containWithchildMenu:items Url:@"11114"];//区域可疑消纳点
            if (four) {
                [section1 addObject:four];
            }
            //************************组分割线************************//
            NSDictionary *five = [self containWithchildMenu:items Url:@"11115"];//区域未密闭
            if (five) {
                [section2 addObject:five];
            }
            NSDictionary *six = [self containWithchildMenu:items Url:@"11116"];//区域超速率
            if (six) {
                [section2 addObject:six];
            }
            [tempArr addObject:section1];
            [tempArr addObject:section2];
            [filterArray addObject:tempArr];
            
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"区域基础数据统计"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            if (section2 > 0 && section2.count>0) {
                [tempSectionArr addObject:@"区域违规比统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            [filterSectionArray addObject:tempSectionArr];
            
        }else if ([url isEqualToString:@"1112"]){//企业统计报表  两组
            
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            NSMutableArray *section1 = [NSMutableArray array];
            NSMutableArray *section2 = [NSMutableArray array];
            NSDictionary *one = [self containWithchildMenu:items Url:@"11121"];//出土量最多企业
            if (one) {
                [section1 addObject:one];
            }
            NSDictionary *two = [self containWithchildMenu:items Url:@"11122"];//出土量最少企业
            if (two) {
                [section1 addObject:two];
            }
            //************************组分割线************************//
            NSDictionary *three = [self containWithchildMenu:items Url:@"11123"];//未密闭率最高企业
            if (three) {
                [section2 addObject:three];
            }
            NSDictionary *four = [self containWithchildMenu:items Url:@"11124"];//未密闭率最低企业
            if (four) {
                [section2 addObject:four];
            }
            
            NSDictionary *five = [self containWithchildMenu:items Url:@"11125"];//超速率最高企业
            if (five) {
                [section2 addObject:five];
            }
            NSDictionary *six = [self containWithchildMenu:items Url:@"11126"];//超速率最低企业
            if (six) {
                [section2 addObject:six];
            }
            [tempArr addObject:section1];
            [tempArr addObject:section2];
            
            [filterArray addObject:tempArr];
            
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"企业基础数据统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            if (section2 > 0 && section2.count>0) {
                [tempSectionArr addObject:@"企业违规比统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            [filterSectionArray addObject:tempSectionArr];
            
            
        }else if ([url isEqualToString:@"1113"]){//工地统计报表  一组
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            NSMutableArray *section1 = [NSMutableArray array];
            NSDictionary *one = [self containWithchildMenu:items Url:@"11131"];//出土量最多工地
            if (one) {
                [section1 addObject:one];
            }
            NSDictionary *two = [self containWithchildMenu:items Url:@"11132"];//出土量最少工地
            if (two) {
                [section1 addObject:two];
            }
            NSDictionary *three = [self containWithchildMenu:items Url:@"11133"];//提前出土工地
            if (three) {
                [section1 addObject:three];
            }
            NSDictionary *four = [self containWithchildMenu:items Url:@"11134"];//工地出土情况
            if (four) {
                [section1 addObject:four];
            }
            
            NSDictionary *five = [self containWithchildMenu:items Url:@"11135"];//黑工地数
            if (five) {
                [section1 addObject:five];
            }
            [tempArr addObject:section1];
            [filterArray addObject:tempArr];
            
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"工地基础数据统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            [filterSectionArray addObject:tempSectionArr];
            
        }else if ([url isEqualToString:@"1114"]){//消纳点统计报表  一组
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            NSMutableArray *section1 = [NSMutableArray array];
            NSDictionary *one = [self containWithchildMenu:items Url:@"11141"];//消纳量最多消纳点
            if (one) {
                [section1 addObject:one];
            }
            NSDictionary *two = [self containWithchildMenu:items Url:@"11142"];//消纳量最少消纳点
            if (two) {
                [section1 addObject:two];
            }
            [tempArr addObject:section1];
            [filterArray addObject:tempArr];
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"消纳点基础数据统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            [filterSectionArray addObject:tempSectionArr];
            
        }else if ([url isEqualToString:@"1115"]){// 车辆统计报表   三组
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            NSMutableArray *section1 = [NSMutableArray array];
            NSMutableArray *section2 = [NSMutableArray array];
            NSMutableArray *section3 = [NSMutableArray array];
            NSDictionary *one = [self containWithchildMenu:items Url:@"11151"];//上线时长最高车辆
            if (one) {
                [section1 addObject:one];
            }
            NSDictionary *two = [self containWithchildMenu:items Url:@"11152"];//上线时长最低车辆
            if (two) {
                [section1 addObject:two];
            }
            //************************组分割线************************//
            NSDictionary *three = [self containWithchildMenu:items Url:@"11153"];//上线时长最高车辆
            if (three) {
                [section2 addObject:three];
            }
            NSDictionary *four = [self containWithchildMenu:items Url:@"11154"];//未密闭时长最低车辆
            if (four) {
                [section2 addObject:four];
            }
            NSDictionary *five = [self containWithchildMenu:items Url:@"11155"];//超速时长最高车辆
            if (five) {
                [section2 addObject:five];
            }
            NSDictionary *six = [self containWithchildMenu:items Url:@"11156"];//超速时长最低车辆
            if (six) {
                [section2 addObject:six];
            }
            NSDictionary *seven = [self containWithchildMenu:items Url:@"11157"];//超载时长最高车辆
            if (seven) {
                [section2 addObject:seven];
            }
            NSDictionary *eight = [self containWithchildMenu:items Url:@"11158"];//超载时长最低车辆
            if (eight) {
                [section2 addObject:eight];
            }
            //************************组分割线************************//
            NSDictionary *nine = [self containWithchildMenu:items Url:@"11159"];//超载时长最低车辆
            if (nine) {
                [section3 addObject:nine];
            }
            [tempArr addObject:section1];
            [tempArr addObject:section2];
            [tempArr addObject:section3];
            [filterArray addObject:tempArr];
            
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"车辆基础数据统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            if (section2 > 0 && section2.count>0) {
                [tempSectionArr addObject:@"车辆违规时长统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            if (section3 > 0 && section3.count>0) {
                [tempSectionArr addObject:@"车辆设备安装统计报表"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            
            
            
            
            [filterSectionArray addObject:tempSectionArr];
            
            
        }else if ([url isEqualToString:@"1116"]){//专题统计报表
            NSMutableArray *tempArr = [NSMutableArray array];
            NSMutableArray *tempSectionArr = [NSMutableArray array];
            NSMutableArray *section1 = [NSMutableArray array];
            NSDictionary *one = [self containWithchildMenu:items Url:@"11161"];//消纳量最多消纳点
            if (one) {
                [section1 addObject:one];
            }
            [tempArr addObject:section1];
            [filterArray addObject:tempArr];
            
            if (section1 > 0 && section1.count>0) {
                [tempSectionArr addObject:@"专题数据统计排名"];
            }else{
                [tempSectionArr addObject:@" "];
            }
            [filterSectionArray addObject:tempSectionArr];
        }
    }
    [filterArray writeToFile:statisticalPathString atomically:YES];
    
    [filterSectionArray writeToFile:statisticalSectionPathString atomically:YES];
    //                }
    //            }];
    //        }
    //    }];
}

//包含方法
+ (NSDictionary *)containWithchildMenu:(NSArray *)items Url:(NSString *)Url{
    for (NSInteger i = 0; i < items.count; i++) {
        if ([items[i][@"Url"] isEqualToString:Url]) {
            return items[i];
        }
    }
    return nil;
}

@end
