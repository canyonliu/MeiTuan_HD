//
//  MTCategory.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCategory : NSObject

@property (nonatomic, strong)NSArray *subcategories;


@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *small_highlighted_icon;

@property (nonatomic, copy)NSString *small_icon;

@property (nonatomic, copy)NSString *highlighted_icon;

@property (nonatomic, copy)NSString *icon;

@property (nonatomic, copy)NSString *map_icon;

@end
