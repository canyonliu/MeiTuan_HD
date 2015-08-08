//
//  MTRegionViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

/**
 *  显示城市的数据的控制器
 *
 */

#import "MTRegionViewController.h"
#import "UIView+Extension.h"
#import "MTHomeDropdown.h"
#import "MTCityViewController.h"
#import "MTNavigationController.h"
#import "MTMetalTool.h"
#import "MTRegion.h"
#import "MTConst.h"

@interface MTRegionViewController ()<MTHomeDropdownDataSource,MTHomeDropdownDelegate>
- (IBAction)changeCity;

@end

@implementation MTRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [self.view.subviews firstObject];
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    
    dropdown.datasource = self;
    dropdown.delegate = self;
    
    
    dropdown.y = titleView.height;
    [self.view addSubview:dropdown];
    
    //设置控制器在popover中的尺寸
    self.preferredContentSize = CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
    
}


- (IBAction)changeCity {
    [self.popover dismissPopoverAnimated:YES];
    
    MTCityViewController *cityVC = [[MTCityViewController alloc]init];
    MTNavigationController *navVC = [[MTNavigationController alloc]initWithRootViewController:cityVC];
    navVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:navVC animated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:navVC animated:YES completion:nil];
    
    //  self.presentedViewController == navVC 引用着呗modal 出来的控制器
}



#pragma mark - 实现MTHomeDropdownDataSource


-(NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown{
    return  self.regions.count;
}


-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row{
    MTRegion *region = self.regions[row];
    return region.name;
}
//-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown iconForRowInMainTable:(int)row{
//    //MTRegion *region = self.regions[row];
//    return nil;
//
//}
//-(NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(int)row{
//    //MTRegion *region = self.regions[row];
//    return nil;
//
//}
-(NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row{
    MTRegion *region = self.regions[row];
    NSLog(@"......%@",region.subregions);
 
    return region.subregions;

}


#pragma mark - 实现MTHomeDropdownDelegate
-(void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectedRowInMainTable:(int)row{
     MTRegion *region = self.regions[row];
    if(region.subregions.count == 0){
        //发出菜单栏分类没有子数据的数据被点击的通知
        //把模型字典发出去
        [MTNotificationCenter postNotificationName:MTRegionDidChangeNotification object:nil userInfo:@{MTSelectRegionName : region}];
        
    }
    
    NSLog(@"%@",region.name);

}

-(void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectedRowInSubTable:(int)row inMainTable:(int)mainRow{
    MTRegion *region = self.regions[mainRow];
    
    //发出通知
    [MTNotificationCenter postNotificationName:MTRegionDidChangeNotification object:nil userInfo:@{MTSelectRegionName : region , MTSelectSubRegionName:region.subregions[row]}];
    
    
    NSLog(@"..%@..",region.subregions[row]);
}



@end
