//
//  MTHomeDropdown.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/18.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeDropdown.h"
#import "MTCategory.h"

@interface MTHomeDropdown() <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


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
    return self.categories.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    MTCategory *category = self.categories[indexPath.row];
    cell.textLabel.text = category.name;
    cell.imageView.image = [UIImage imageNamed:category.small_icon];
    
    
    
    return cell;
}


#pragma mark -m 数据代理方法




@end
