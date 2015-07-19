//
//  MTCityViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/19.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MJExtension.h"
#import "MTCityGroup.h"

#import "Masonry.h"


const int coverTag  = 45;

@interface MTCityViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong)NSArray *cityGroup;

@end

@implementation MTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //基本设置
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" highImage:@"btn_navigation_close_hl"];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    //加载城市数据
    self.cityGroup = [MTCityGroup objectArrayWithFilename:@"cityGroups.plist"];
}


#pragma mark 搜索框的代理方法
/**
 *  键盘弹出:搜索框开始编辑文字
 */
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //2.显示遮盖
    UIView *cover = [[UIView alloc]init];
    
    cover.tag = coverTag;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.3;
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self.searchBar action:@selector(resignFirstResponder)]];
    [self.view addSubview:cover];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_left);
        make.right.equalTo(self.tableView.mas_right);
        make.top.equalTo(self.tableView.mas_top);
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];
//    3.修改搜索框的背景图片
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    
}

/**
 *  键盘退下:搜索框结束编辑文字
 */

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [[self.view viewWithTag:coverTag] removeFromSuperview];
    
    
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
}

#pragma mark -m 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    MTCityGroup *group = self.cityGroup[section];
    return group.cities.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.cityGroup.count;

}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    MTCityGroup *cityGroup = self.cityGroup[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    
    return cell;
}

#pragma mark -m代理方法

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MTCityGroup *group = self.cityGroup[section];
    return group.title;

}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSMutableArray *group = [NSMutableArray array];
//    for(MTCityGroup *citygroup in self.cityGroup){
//        [group addObject:citygroup.title];
//    }
//    
//    return  group;
    
    
    /**
     *  使用KVC
     */
    return [self.cityGroup valueForKey:@"title"];
}


- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
