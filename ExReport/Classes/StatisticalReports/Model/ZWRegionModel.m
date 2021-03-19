//
//  ZWRegionModel.m
//  Muck
//
//  Created by 张威 on 2018/8/6.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWRegionModel.h"

@implementation ZWRegionModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.Code forKey:@"Code"];
    [aCoder encodeObject:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.Name forKey:@"Name"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        self.Code = [aDecoder decodeObjectForKey:@"Code"];
        self.Id = [aDecoder decodeObjectForKey:@"Id"];
        self.Name = [aDecoder decodeObjectForKey:@"Name"];
    }
    return self;
}

@end
