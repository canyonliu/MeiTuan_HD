//
//  MTHomeDropdown.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//
#import <UIKit/UIKit.h>
@class MTHomeDropdown;

/**
 *  具体数据的类型
 */
//@protocol MTHomeDropdownData <NSObject>
//
//- (NSString *)title;
//- (NSString *)icon;
//- (NSString *)selectedIcon;
//- (NSArray *)subdata;
//
//@end

@protocol MTHomeDropdownDataSource <NSObject>
/**
 *  左边表格一共有多少行
 *
 */
- (NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown;
///**
// *  左边每一行表哥的具体数据
// *
// *  @param row          行号
// *
// *这里用到了另外一个协议MTHomeDropdownData,告诉左边表哥应该返回什么样的数据,如果不用的话就要写4个方法
// 但是如果这样使用的话会造成在模型数据那里需要遵守MTHomeDropdownData这个协议,显得不是很好
// */
//- (id<MTHomeDropdownData>)homeDropdown:(MTHomeDropdown *)homeDropdown dataForRowInMainTable:(int)row;

/**
 *  左边每一行的标题
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row;
/**
 *  左边每一行的图标
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown iconForRowInMainTable:(int)row;
/**
 *  左边每一行的选中图标
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(int)row;
/**
 *  左边每一行的子数据
 */
- (NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row;





@end



@interface MTHomeDropdown : UIView

+(instancetype)dropdown;
@property (nonatomic ,weak) id<MTHomeDropdownDataSource>datasource;


//@property (nonatomic, strong)NSArray *categories;

@end
