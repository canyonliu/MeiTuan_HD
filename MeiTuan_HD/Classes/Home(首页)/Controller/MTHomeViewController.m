//
//  MTHomeViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/7/17.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTConst.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "MTHomeLeftTopMenu.h"
#import "MTCategoryViewController.h"
#import "MTRegionViewController.h"
#import "MTSortViewController.h"
#import "MTMetalTool.h"
#import "MTCity.h"
#import "MTRegion.h"
#import "MTSort.h"
#import "MTCategory.h"
#import "DPAPI.h"


@interface MTHomeViewController ()<DPRequestDelegate>

@property (nonatomic ,weak) UIBarButtonItem  *categoryMenu;
@property (nonatomic ,weak) UIBarButtonItem  *regionMenu;
@property (nonatomic ,weak) UIBarButtonItem  *sortMenu;

//@property (nonatomic, strong) UIPopoverController *popover;
/**选中的城市名字****/
@property (nonatomic ,copy) NSString  *selectedCityName ;
/**选中的分类名字****/
@property (nonatomic ,copy) NSString  *selectedCategoryName ;
/**选中的区域名字****/
@property (nonatomic ,copy) NSString  *selectedRegionName ;
/**选中的排序****/
@property (nonatomic ,strong) MTSort  *selectedSort;

/** 排序的popover */
@property (nonatomic, strong) UIPopoverController *sortPopover;
/** 区域的popover */
@property (nonatomic, strong) UIPopoverController *regionPopover;
/** 类别的popover */
@property (nonatomic, strong) UIPopoverController *categoryPopover;
@end

@implementation MTHomeViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    return [self initWithCollectionViewLayout:flowlayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.collectionView.backgroundColor = MTColor(233, 233, 233);
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //监听城市的改变,然后刷新本页面
    [MTNotificationCenter addObserver:self selector:@selector(cityDidSelected:) name:MTCityDidSelectNotification object:nil];
    //监听排序改变
    [MTNotificationCenter addObserver:self selector:@selector(sortDidSelected:) name:MTSortDidChangeNotification object:nil];
    //监听分类改变
    [MTNotificationCenter addObserver:self selector:@selector(categoryDidSelected:) name:MTCategoryDidChangeNotification object:nil];
    //监听区域改变
    [MTNotificationCenter addObserver:self selector:@selector(regionDidSelected:) name:MTRegionDidChangeNotification object:nil];

    
    
    //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];
}



#pragma mark -m dealloc 注销通知
-(void)dealloc{
    [MTNotificationCenter removeObserver:self];
}

#pragma mark -m 监听城市改变通知
- (void)cityDidSelected:(NSNotification *)notification{
    NSString * citySelectedName = notification.userInfo[MTSelectCityName];
    self.selectedCityName = citySelectedName;
    
    MTLog(@"首页控制器监听到改变 ---- %@",citySelectedName);
    //首页顶部buttonItem 的文字图标等发生改变
//    MTHomeLeftTopMenu *topItem = [MTHomeLeftTopMenu item];
    MTHomeLeftTopMenu *topItem = (MTHomeLeftTopMenu *)self.regionMenu.customView;
    [topItem setTitle:[NSString stringWithFormat:@"%@ - 全部",self.selectedCityName]];
    [topItem setSubTitle:nil];
    //2.关闭popover
    //[self.regionPopover dismissPopoverAnimated:YES];
    
    //3.刷新表格数据
    [self loadNewDeals];
    
    
}

#pragma mark -m 监听排序改变通知
- (void)sortDidSelected:(NSNotification *)notification{
    //1.修改顶部排序item的改变
    self.selectedSort = notification.userInfo[MTSelectSortName];
        //首页顶部buttonItem 的文字图标等发生改变
    MTHomeLeftTopMenu *topItem = (MTHomeLeftTopMenu *)self.sortMenu.customView;
    [topItem setSubTitle:self.selectedSort.label];
    
    //2.关闭popover
    [self.sortPopover dismissPopoverAnimated:YES];
    
    
    //3.刷新表格数据
    [self loadNewDeals];

}

#pragma mark -m 监听分类改变通知
- (void)categoryDidSelected:(NSNotification *)notification{
    //1.修改顶部排序item的改变
    MTCategory *category = notification.userInfo[MTSelectCategoryName];
    NSString *subcategoryname = notification.userInfo[MTSelectSubCategoryName];
    if (subcategoryname == nil || [subcategoryname isEqualToString:@"全部"]) {
        self.selectedCategoryName = category.name;
    }else{
        self.selectedCategoryName = subcategoryname;
    }
    if([self.selectedCategoryName isEqualToString:@"全部分类"]){
        self.selectedCategoryName = nil;
    }
    
//    if((subcategoryname == nil || [subcategoryname isEqualToString:@"全部"]) && ![category.name isEqualToString:@"全部分类"]){
//        self.selectedCategoryName = category.name;
//    }else{
//        self.selectedCategoryName = nil;
//    }
   
    
    
    
    //首页顶部buttonItem 的文字图标等发生改变
    MTHomeLeftTopMenu *topItem = (MTHomeLeftTopMenu *)self.categoryMenu.customView;
    
    [topItem setTitle:category.name];
    [topItem setSubTitle:subcategoryname?subcategoryname:@"全部"];
    [topItem setIcon:category.icon highlighedIcon:category.highlighted_icon];
    
    
    //2.关闭popover
    [self.categoryPopover dismissPopoverAnimated:YES];
    
    
    //3.刷新表格数据
    [self loadNewDeals];
    
}

#pragma mark -m 监听区域改变通知
- (void)regionDidSelected:(NSNotification *)notification{
    //1.修改顶部排序item的改变
    MTRegion *region = notification.userInfo[MTSelectRegionName];
    NSString *subregionname = notification.userInfo[MTSelectSubRegionName];
    //首页顶部buttonItem 的文字图标等发生改变
    MTHomeLeftTopMenu *topItem = (MTHomeLeftTopMenu *)self.regionMenu.customView;
    
    [topItem setTitle:[NSString stringWithFormat:@"%@ - %@",self.selectedCityName,region.name]];
    [topItem setSubTitle:subregionname?subregionname:@"全部"];
//    [topItem setIcon:category.icon highlighedIcon:category.highlighted_icon];
    
    
    if (subregionname == nil || [subregionname isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
    }else{
        self.selectedRegionName = subregionname;
    }
    if([self.selectedCategoryName isEqualToString:@"全部"]){
        self.selectedCategoryName = nil;
    }
    
    //2.关闭popover
    [self.regionPopover dismissPopoverAnimated:YES];
    
    
    //3.刷新表格数据
    [self loadNewDeals];
    
}


#pragma mark -m 刷新表格数据(跟服务器交互)
- (void)loadNewDeals{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //城市
    params[@"city"] = self.selectedCityName;
    //分类
    if(self.selectedCategoryName){
    params[@"category"] = self.selectedCategoryName;
    }
    
    //每页的条数
    params[@"limit"] = @5;
    //排序
    if(self.selectedSort){
    params[@"sort"] = @(self.selectedSort.value);
    }
    //区域
    if(self.selectedRegionName){
        params[@"region"] = self.selectedRegionName;
    }
    
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];

    MTLog(@"请求参数是:::: %@",params);
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    MTLog(@"请求成功 --- %@",result);
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
     MTLog(@"请求失败 --- %@",error);
}




#pragma mark -m 设置左边导航栏内容
- (void)setupLeftNav{
    UIBarButtonItem *LOGOBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    LOGOBar.enabled = NO;
    
    //2.类别
    MTHomeLeftTopMenu *categoryMenu = [MTHomeLeftTopMenu item];
    [categoryMenu addTarget:self action:@selector(categoryClicked)];
    UIBarButtonItem *catrgoryBar = [[UIBarButtonItem alloc]initWithCustomView:categoryMenu];
    self.categoryMenu = catrgoryBar;
    
    //3.地区
    MTHomeLeftTopMenu *regionMenu = [MTHomeLeftTopMenu item];
    [regionMenu addTarget:self action:@selector(regionClicked)];
    UIBarButtonItem *regionBar = [[UIBarButtonItem alloc]initWithCustomView:regionMenu];
    self.regionMenu = regionBar;
    
    //4.排序
    MTHomeLeftTopMenu *sortMenu = [MTHomeLeftTopMenu item];
    //一开始就设置好
    [sortMenu setIcon:@"icon_sort" highlighedIcon:@"icon_sort_highlighted"];
    [sortMenu setTitle:@"排序"];
    
    
    [sortMenu addTarget:self action:@selector(sortClicked)];
    UIBarButtonItem *sortBar = [[UIBarButtonItem alloc]initWithCustomView:sortMenu];
    self.sortMenu = sortBar;
    
    
    self.navigationItem.leftBarButtonItems = @[LOGOBar,catrgoryBar,regionBar,sortBar];
    
}

#pragma mark -m 设置右边导航栏内容
-(void)setupRightNav{
    UIBarButtonItem *mapBar = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" highImage:@"icon_map_highlighted"];
    mapBar.customView.width = 55;
    
    UIBarButtonItem *searchBar = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" highImage:@"icon_search_highlighted"];
    searchBar.customView.width = 55;
    
    self.navigationItem.rightBarButtonItems = @[mapBar,searchBar];
    
}


#pragma mark -m 顶部menu的点击方法

- (void)categoryClicked{
//    MTLog(@"categoryClicked");
    self.categoryPopover = [[UIPopoverController alloc]initWithContentViewController:[[MTCategoryViewController alloc]init] ];
    
    [self.categoryPopover presentPopoverFromBarButtonItem:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}

- (void)regionClicked{
    
    MTRegionViewController *region = [[MTRegionViewController alloc]init];
    
    if(self.selectedCityName){
        //获取当前选中城市的区域
        MTCity *city =  [[[MTMetalTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] firstObject];
//        MTRegion *region = city.regions[1];
//        NSLog(@"%@,,,,ssss",region.subRegions);
        region.regions = city.regions;

    }
   
    self.regionPopover = [[UIPopoverController alloc]initWithContentViewController:region];
    
    [self.regionPopover presentPopoverFromBarButtonItem:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
     region.popover = self.regionPopover;
}

- (void)sortClicked{
    // 显示排序菜单
    self.sortPopover = [[UIPopoverController alloc] initWithContentViewController:[[MTSortViewController alloc] init]];
    [self.sortPopover presentPopoverFromBarButtonItem:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
