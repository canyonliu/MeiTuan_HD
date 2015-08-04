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


//别人即可以设置,又可以访问
//@property (nonatomic, copy)NSString *title;
//
//@property (nonatomic, copy)NSString *subTitle;

//只允许别人设置,不允许别人访问
-(void)setTitle:(NSString *)title;
-(void)setSubTitle:(NSString *)subTitle;

-(void)setIcon:(NSString *)icon highlighedIcon:(NSString *)highlighedIcon;



@end
