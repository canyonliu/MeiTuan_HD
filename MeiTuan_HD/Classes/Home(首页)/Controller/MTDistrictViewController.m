//
//  MTDistrictViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

/**
 *  显示城市的数据的控制器
 *
 */

#import "MTDistrictViewController.h"
#import "UIView+Extension.h"
#import "MTHomeDropdown.h"
#import "MTCityViewController.h"
#import "MTNavigationController.h"

@interface MTDistrictViewController ()
- (IBAction)changeCity;

@end

@implementation MTDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [self.view.subviews firstObject];
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    dropdown.y = titleView.height;
    [self.view addSubview:dropdown];
    
    //设置控制器在popover中的尺寸
    self.preferredContentSize = CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
    
}


- (IBAction)changeCity {
    MTCityViewController *cityVC = [[MTCityViewController alloc]init];
    MTNavigationController *navVC = [[MTNavigationController alloc]initWithRootViewController:cityVC];
    navVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navVC animated:YES completion:nil];
}
@end
