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
#import "MJExtension.h"
#import "MTDeal.h"
#import "MJRefresh.h"


#import "MBProgressHUD+MJ.h"
#import "UIView+AutoLayout.h"
#import "MTSearchViewController.h"
#import "MTNavigationController.h"

#import "AwesomeMenu.h"
#import "MTCollectViewController.h"
#import "MTRecentViewController.h"

@interface MTHomeViewController () <AwesomeMenuDelegate>

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





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNotifications];
        //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];

    // 创建awesomemenu
    [self setupAwesomeMenu];
    
    
    
}


- (void)setupNotifications
{
    //监听城市的改变,然后刷新本页面
    [MTNotificationCenter addObserver:self selector:@selector(cityDidSelected:) name:MTCityDidSelectNotification object:nil];
    //监听排序改变
    [MTNotificationCenter addObserver:self selector:@selector(sortDidSelected:) name:MTSortDidChangeNotification object:nil];
    //监听分类改变
    [MTNotificationCenter addObserver:self selector:@selector(categoryDidSelected:) name:MTCategoryDidChangeNotification object:nil];
    //监听区域改变
    [MTNotificationCenter addObserver:self selector:@selector(regionDidSelected:) name:MTRegionDidChangeNotification object:nil];
}


- (void)setupAwesomeMenu
{
    // 1.中间的item
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:nil];
    
    // 2.周边的item
    AwesomeMenuItem *item0 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    AwesomeMenuItem *item3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    
    NSArray *items = @[item0, item1, item2, item3];
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    menu.alpha = 0.5;
    // 设置菜单的活动范围
    menu.menuWholeAngle = M_PI_2;
    // 设置开始按钮的位置
    menu.startPoint = CGPointMake(50, 150);
    // 设置代理
    menu.delegate = self;
    // 不要旋转中间按钮
    menu.rotateAddButton = NO;
    [self.view addSubview:menu];
    
    // 设置菜单永远在左下角
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoSetDimensionsToSize:CGSizeMake(200, 200)];

}

#pragma mark - AwesomeMenuDelegate
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    
    // 完全显示
    menu.alpha = 1.0;
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    
    // 半透明显示
    menu.alpha = 0.5;
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    // 替换菜单的图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    
    switch (idx) {
        case 0: { // 收藏
            MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:[[MTCollectViewController alloc] init]];
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
            
        case 1: { // 最近访问记录
            MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:[[MTRecentViewController alloc] init]];
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
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
//    [self loadNewDeals];
    [self.collectionView headerBeginRefreshing];
    
    
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
//    [self loadNewDeals];
    [self.collectionView headerBeginRefreshing];

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
//    [self loadNewDeals];
    [self.collectionView headerBeginRefreshing];
    
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
//    [self loadNewDeals];
    [self.collectionView headerBeginRefreshing];
    
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
    
    UIBarButtonItem *searchBar = [UIBarButtonItem itemWithTarget:self action:@selector(searchClicked) image:@"icon_search" highImage:@"icon_search_highlighted"];
    searchBar.customView.width = 55;
    
    self.navigationItem.rightBarButtonItems = @[mapBar,searchBar];
    
}


#pragma mark -m 顶部menu的点击方法


-(void)searchClicked{
    MTNavigationController *nav = [[MTNavigationController alloc]initWithRootViewController:[[MTSearchViewController alloc]init]];
    [self presentViewController:nav animated:YES completion:nil];
}

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

#pragma mark - 实现父类提供的方法

-(void)setupParams:(NSMutableDictionary *)params{
    //城市
    params[@"city"] = self.selectedCityName;
    //分类
    if(self.selectedCategoryName){
        params[@"category"] = self.selectedCategoryName;
    }
    
    //排序
    if(self.selectedSort){
        params[@"sort"] = @(self.selectedSort.value);
    }
    //区域
    if(self.selectedRegionName){
        params[@"region"] = self.selectedRegionName;
    }
}

@end
