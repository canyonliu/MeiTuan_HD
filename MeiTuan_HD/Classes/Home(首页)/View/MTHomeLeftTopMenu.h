//
//  MTHomeLeftTopMenu.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/17.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeLeftTopMenu : UIView

+(instancetype)item;

/**
 *  设置点击的监听器
 *
 */
-(void)addTarget:(id)target action:(SEL)action;

@end
