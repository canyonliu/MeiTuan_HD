//
//  MTDealsViewController.h
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/22.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDealsViewController : UICollectionViewController
/**
 *  设置请求参数:交给子类去实现
 */
- (void)setupParams: (NSMutableDictionary *)params;
@end
