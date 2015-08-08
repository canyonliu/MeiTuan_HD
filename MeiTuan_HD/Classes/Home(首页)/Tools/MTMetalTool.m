//
//  MTMetalTool.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/4.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTMetalTool.h"
#import "MTCity.h"
#import "MJExtension.h"
#import "MTCategory.h"
#import "MTSort.h"

@implementation MTMetalTool
static NSArray *_cities;

+(NSArray *)cities{
    if(_cities == nil){
        _cities = [MTCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}



static NSArray *_categories;

+(NSArray *)categories{
    if(_categories == nil){
        _categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

static NSArray *_sorts;

+(NSArray *)sorts{
    if(_sorts == nil){
        _sorts = [MTSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}



@end
