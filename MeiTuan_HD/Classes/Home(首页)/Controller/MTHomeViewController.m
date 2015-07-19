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
#import "MTDistrictViewController.h"


@interface MTHomeViewController ()

@property (nonatomic ,weak) UIBarButtonItem  *categoryMenu;
@property (nonatomic ,weak) UIBarButtonItem  *districtMenu;
@property (nonatomic ,weak) UIBarButtonItem  *sortMenu;

@property (nonatomic, strong) UIPopoverController *popover;

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
    
    //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];
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
    MTHomeLeftTopMenu *districtMenu = [MTHomeLeftTopMenu item];
    [districtMenu addTarget:self action:@selector(districtClicked)];
    UIBarButtonItem *districtBar = [[UIBarButtonItem alloc]initWithCustomView:districtMenu];
    self.districtMenu = districtBar;
    
    //4.排序
    MTHomeLeftTopMenu *sortMenu = [MTHomeLeftTopMenu item];
    [sortMenu addTarget:self action:@selector(sortClicked)];
    UIBarButtonItem *sortBar = [[UIBarButtonItem alloc]initWithCustomView:sortMenu];
    self.sortMenu = sortBar;
    
    
    self.navigationItem.leftBarButtonItems = @[LOGOBar,catrgoryBar,districtBar,sortBar];
    
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
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:[[MTCategoryViewController alloc]init] ];
    
    [popover presentPopoverFromBarButtonItem:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    self.popover = popover;
    
}

- (void)districtClicked{
    
    UIPopoverController *popover = [[UIPopoverController alloc]initWithContentViewController:[[MTDistrictViewController alloc]init] ];
    
    [popover presentPopoverFromBarButtonItem:self.districtMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)sortClicked{
    
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
