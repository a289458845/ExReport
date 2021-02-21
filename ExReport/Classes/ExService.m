//
//  ExService.m
//  ExReport
//
//  Created by exsun on 2021/2/4.
//

#import "ExService.h"
static ExService * _service ;
@implementation ExService

+(ExService *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[ExService alloc]init];
    });
    return _service;
}

-(void)print
{
    NSLog(@"aaaa");
}

@end
