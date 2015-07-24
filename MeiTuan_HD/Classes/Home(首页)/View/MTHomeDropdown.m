//
//  MTHomeDropdown.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeDropdown.h"
#import "MTCategory.h"
#import "MTHomeDropdownMainCell.h"
#import "MTHomeDropdownSubCell.h"

@interface MTHomeDropdown() <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;


@property (nonatomic, strong)MTCategory *selectedCategory;

@end

@implementation MTHomeDropdown


+(instancetype)dropdown{
    return [[[NSBundle mainBundle]loadNibNamed:@"MTHomeDropdown" owner:nil options:nil]firstObject];
}

-(void)setCategories:(NSArray *)categories{
    _categories = categories;
    //刷新数据
    [self.mainTableView reloadData];
    
}

- (void)awakeFromNib
{
    // 不需要跟随父控件的尺寸变化而伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}



#pragma mark -m 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.mainTableView){
        return self.categories.count;
    }else{
        return self.selectedCategory.subcategories.count;
    }
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if(tableView == self.mainTableView){
        cell = [MTHomeDropdownMainCell cellWithTableView:tableView];
        //显示文字
        MTCategory *category = self.categories[indexPath.row];
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        
        if(category.subcategories.count){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }

    }else{
        //static NSString *subID =@"sub-cell";
        cell = [MTHomeDropdownSubCell cellWithTableView:tableView];
        
//        if(!cell){
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:subID];
//            cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
//            cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
//        }
        cell.textLabel.text = self.selectedCategory.subcategories[indexPath.row];
//        cell.imageView.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        
        
    }
    
    
    
   
    return cell;
}


#pragma mark -m 数据代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView  == self.mainTableView){
        self.selectedCategory = self.categories[indexPath.row];
        [self.subTableView reloadData];
    }
    

    
}


@end
