//
//  MTHomeDropdown.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeDropdown.h"

@implementation MTHomeDropdown


+(instancetype)dropdown{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeDropdown" owner:nil options:nil]firstObject];
}


@end
