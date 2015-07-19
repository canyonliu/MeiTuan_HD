//
//  MTCity.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCity : NSObject
/** 城市名字*/
@property (nonatomic, copy)NSString *name;
/** 城市名字的拼音*/
@property (nonatomic, copy)NSString *pinYin;
/** 城市名字的拼音声母*/
@property (nonatomic, copy)NSString *pinYinHead;
/** 城市的区域(存放的是MTregion模型)*/
@property (nonatomic, strong)NSArray *regions;

@end
