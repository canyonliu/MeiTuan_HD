//
//  MTCity.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTCity.h"
#import "MJExtension.h"
#import "MTRegion.h"

@implementation MTCity

- (NSDictionary *)objectClassInArray{
    return @{@"regions" : [MTRegion class]};
}

@end
