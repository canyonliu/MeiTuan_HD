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
#import "MTMetalTool.h"

@interface MTCategoryViewController ()<MTHomeDropdownDataSource>

@end

@implementation MTCategoryViewController

- (void)loadView{
    /**
     *  加载分类的数据
     */
    //1.
    //    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
    //    NSArray *categories = [MTCategory objectArrayWithKeyValuesArray:dictArray];
    
    //    2.
    //    NSArray *categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    
    
    MTHomeDropdown *dropDown = [MTHomeDropdown dropdown];
    dropDown.datasource = self;
    
    
    
//    dropDown.categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    //[self.view addSubview:dropDown];
    self.view = dropDown;
    
    // 设置控制器view在popover中的尺寸
    self.preferredContentSize = dropDown.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}


-(NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown{
    return  [MTMetalTool categories].count;
}


-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row{
    MTCategory *category = [MTMetalTool categories][row];
    return category.name;
}
-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown iconForRowInMainTable:(int)row{
    MTCategory *category = [MTMetalTool categories][row];
    return category.small_icon;
}
-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(int)row{
    MTCategory *category = [MTMetalTool categories][row];
    return category.small_highlighted_icon;
}
-(NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row{
    MTCategory *category = [MTMetalTool categories][row];
    return category.subcategories;
}



@end
