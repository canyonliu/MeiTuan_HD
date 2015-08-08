//
//  MTRegion.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRegion : NSObject

/**
 *  区域名字
 */
@property (nonatomic, copy)NSString *name;
/**
 *  区域子数据
 */
@property (nonatomic, strong)NSArray *subregions;


@end
