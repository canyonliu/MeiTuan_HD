//
//  MTNavigationController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/17.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTNavigationController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController



+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
