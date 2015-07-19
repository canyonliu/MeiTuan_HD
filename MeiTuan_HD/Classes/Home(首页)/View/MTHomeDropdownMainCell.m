//
//  MTHomeDropdownMainCell.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeDropdownMainCell.h"

@implementation MTHomeDropdownMainCell
/**
 *  初始化
 *
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *mainID =@"main-cell";
    MTHomeDropdownMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    
    if(!cell){
        cell = [[MTHomeDropdownMainCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainID];
        
    }
   return cell;
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    
    return self;
}


@end
