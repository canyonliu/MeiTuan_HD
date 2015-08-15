//
//  MTCenterLineLabel.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/15.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTCenterLineLabel.h"

@implementation MTCenterLineLabel

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    /**1.画线段*/
//    //获得上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //画线
//    //设置起点
//    CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5);
//    //连线到另外一个点
//    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5);
//    //渲染
//    CGContextStrokePath(ctx);
    
    /**2.画矩形*/
    UIRectFill(CGRectMake(0, rect.size.height
                          *0.5, rect.size.width, 1));
}

@end
