//
//  EXViewController.m
//  ExReport
//
//  Created by a289458845 on 02/04/2021.
//  Copyright (c) 2021 a289458845. All rights reserved.
//

#import "EXViewController.h"
#import <ExReport/ExReport.h>
@interface EXViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation EXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * path = [rTools getResrouceBundleWithName:@"commonreport_thehighest_first_icon@3x" type:@"png" folderName:@"Image"];

    self.img.image = [UIImage imageWithContentsOfFile:path];
    

}

// 读取本地JSON文件
- (NSArray *)readLocalFileWithName:(NSString *)name {
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    //获取文件内容
    NSString *jsonStr  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //将文件内容转成数据
    NSData *jaonData   = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    //将数据转成数组
    NSArray *provinceSchoolArray = [NSJSONSerialization JSONObjectWithData:jaonData options:NSJSONReadingMutableContainers error:nil];
    
    return provinceSchoolArray;
}

- (IBAction)action:(UIButton *)sender {
  
    NSArray * dic = [self readLocalFileWithName:@"data"];
    ZWStatisticalReportsViewController * vc = [[ExService manager]goToBaseVC];
    vc.dataArray = dic;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
