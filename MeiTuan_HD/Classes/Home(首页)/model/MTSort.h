//
//  MTSort.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/8.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSort : NSObject
/**
 *  排序名称
 */
@property (nonatomic, copy)NSString *label;
/**
 *  排序的值(以后需要发送给服务器)
 */
@property (nonatomic, assign)int value;

@end
