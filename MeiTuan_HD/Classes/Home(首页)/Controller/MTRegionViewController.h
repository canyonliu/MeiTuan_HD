//
//  MTRegionViewController.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTRegionViewController : UIViewController

@property (nonatomic, strong)NSArray *regions;
@property (nonatomic ,weak) UIPopoverController *popover;
@end
