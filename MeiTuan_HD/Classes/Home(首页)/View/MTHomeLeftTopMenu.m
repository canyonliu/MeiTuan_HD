//
//  MTHomeLeftTopMenu.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/17.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeLeftTopMenu.h"

@interface MTHomeLeftTopMenu()

@property (weak, nonatomic) IBOutlet UIButton *iconButton;


@end


@implementation MTHomeLeftTopMenu

+(instancetype)item{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeLeftTopMenu" owner:nil options:nil]firstObject];
}


-(void)addTarget:(id)target action:(SEL)action{
    
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
}
@end
