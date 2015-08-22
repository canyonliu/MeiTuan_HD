//
//  MTSearchViewController.m
//  MeiTuan_HD
//
//  Created by WayneLiu on 15/8/16.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "MTSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MTConst.h"
#import "UIView+Extension.h"
#import "MJRefresh.h"

@interface MTSearchViewController ()<UISearchBarDelegate>

@end

@implementation MTSearchViewController

//static NSString * const reuseIdentifier = @"Cell";

//- (instancetype)init{
//    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
//    //cell的大小
////    flowlayout.itemSize = CGSizeMake(305, 305);
//    //    在下面监听到频幕旋转的时候在设置内边距
//    //    CGFloat inset = 15;
//    //    flowlayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
//    return [self initWithCollectionViewLayout:flowlayout];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = MTGlobalBg;
    //
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];

    
    //自定义view
    UIView *titleView = [[UIView alloc]init];
    titleView.height = 35;
    titleView.width = 300;
    self.navigationItem.titleView = titleView;
    
    //中间的搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.frame = self.navigationItem.titleView.bounds;
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    searchBar.placeholder = @"请输入关键字";
    
    [titleView addSubview:searchBar];
    
    
//    self.navigationItem.titleView = searchBar;
//    searchBar.autoresizingMask = UIViewAutoresizingNone;
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

}

#pragma mark 搜索框代理

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
 
    //刷新,发送请求给服务器
    [self.collectionView headerBeginRefreshing];
    
    //退出键盘
    [searchBar resignFirstResponder];
}



- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 实现父类提供的方法

-(void)setupParams:(NSMutableDictionary *)params{
    params[@"city"] = @"北京";
    UISearchBar *bar = (UISearchBar *)self.navigationItem.titleView.subviews[0];
    params[@"keyword"] = bar.text;
    
}

@end
