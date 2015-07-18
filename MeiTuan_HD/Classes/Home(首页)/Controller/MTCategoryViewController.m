//
//  MTCategoryViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTCategoryViewController.h"
#import "MTHomeDropdown.h"
#import "MTCategory.h"
#import "MJExtension.h"
#import "UIView+Extension.h"

@interface MTCategoryViewController ()

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  加载分类的数据
     */
    //1.
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
//    NSArray *categories = [MTCategory objectArrayWithKeyValuesArray:dictArray];
    
//    2.
//    NSArray *categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    
    
    MTHomeDropdown *dropDown = [MTHomeDropdown dropdown];
    dropDown.categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    [self.view addSubview:dropDown];
    
//    // 设置控制器view在popover中的尺寸
//    self.preferredContentSize = dropDown.size;
}




@end
