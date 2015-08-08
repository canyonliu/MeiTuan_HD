//
//  MTMetalTool.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/4.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//
//元数据工具类:管理所有的元数据(固定的描述数据)
#import <Foundation/Foundation.h>

@interface MTMetalTool : NSObject

/**
 *  返回344个城市
 */
+ (NSArray *)cities;
/**
 *  返回所有的分类数据
 *
 */
+ (NSArray *)categories;

@end
