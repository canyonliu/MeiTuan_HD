//
//  MTHomeDropdownSubCell.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeDropdownSubCell.h"

@implementation MTHomeDropdownSubCell


/**
 *  初始化
 *
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *subID =@"sub-cell";
    MTHomeDropdownSubCell *cell = [tableView dequeueReusableCellWithIdentifier:subID];
    
    if(!cell){
        cell = [[MTHomeDropdownSubCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:subID];
        
    }
    return cell;
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    }
    
    return self;
}

@end
