//
//  MTCityGroup.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroup : NSObject
/** 标题*/
@property (nonatomic, copy)NSString *title;
/** 这一组的所有城市*/
@property (nonatomic, strong)NSArray *cities;


@end
