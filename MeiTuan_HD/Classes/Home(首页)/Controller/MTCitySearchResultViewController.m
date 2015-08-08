//
//  MTCitySearchResultViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/25.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTCitySearchResultViewController.h"
#import "MTCity.h"
#import "MTCityViewController.h"
#import "MTConst.h"

#import "MTMetalTool.h"

@interface MTCitySearchResultViewController ()
@property (nonatomic, strong)NSArray *resultCities;

@end

@implementation MTCitySearchResultViewController



- (void)setSearchText:(NSString *)searchText{
    _searchText = [searchText copy];
    
    searchText = searchText.lowercaseString;
    

    
    
//    self.resultCities = [NSMutableArray array];
    //根据关键字搜索城市数据
    
//    1.直接遍历
    
//    for(MTCity *city in self.cities){
//        //city里面的数据本身就是小写
//        if([city.name containsString:searchText] || [city.pinYinHead containsString:searchText] || [city.pinYin containsString:searchText]){
//            [self.resultCities addObject:city];
//        }
//    }
    
    //2.谓词/过滤器:能利用一定的条件从一个数组中过滤出想要的数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@",searchText,searchText,searchText];
    self.resultCities = [[MTMetalTool cities] filteredArrayUsingPredicate:predicate];
    
    
    
    
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.resultCities.count;
}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    MTCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"共有%d个搜索结果",self.resultCities.count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MTCity *city = self.resultCities[indexPath.row];
    //发出通知
    [MTNotificationCenter postNotificationName:MTCityDidSelectNotification object:nil userInfo:@{MTSelectCityName : city.name}];
    
    //当前控制器销毁
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
